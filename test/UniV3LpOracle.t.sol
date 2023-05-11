// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.4;

import "forge-std/Test.sol";

import "../src/UniV3LpOracle.sol";

contract UniV3LpOracleTest is Test {
    FeedRegistryInterface immutable CHAINLINK = FeedRegistryInterface(vm.envAddress("CHAINLINK"));
    address immutable WETH = vm.envAddress("WETH");
    address immutable WBTC = vm.envAddress("WBTC");
    UniV3LpOracle oracle;

    function setUp() public {
        oracle = new UniV3LpOracle(CHAINLINK, WETH, WBTC);
    }

    function test_quoteUSD_ETHBTC() public view {
        uint256 valueUSD = oracle.quoteUSD(
            IUniswapV3Pool(0xCBCdF9626bC03E24f779434178A73a0B4bad62eD), 257220, 257820, 644350055919596, 1800, 1 days
        );
        console.log("valueUSD", valueUSD);
    }

    function test_quoteUSD_frxETHETH() public view {
        uint256 valueUSD = oracle.quoteUSD(
            IUniswapV3Pool(0x8a15b2Dc9c4f295DCEbB0E7887DD25980088fDCB), -20, 20, 19755028813714897209669, 1800, 1 days
        );
        console.log("valueUSD", valueUSD);
    }
}
