// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.4;

import "forge-std/Test.sol";

import "../src/UniV3LpOracle.sol";

contract UniV3LpOracleTest is Test {
    FeedRegistryInterface immutable CHAINLINK = FeedRegistryInterface(vm.envAddress("CHAINLINK"));
    address immutable WETH = vm.envAddress("WETH");
    address immutable WBTC = vm.envAddress("WBTC");
    address immutable USDC = vm.envAddress("USDC");
    address immutable USDT = vm.envAddress("USDT");
    address immutable DAI = vm.envAddress("DAI");
    address immutable FRAX = vm.envAddress("FRAX");
    UniV3LpOracle oracle;

    function setUp() public {
        oracle = new UniV3LpOracle(CHAINLINK, WETH, WBTC, USDC, USDT, DAI, FRAX);
    }

    function test_quoteUSD_ETHBTC() public view {
        uint256 valueUSD = oracle.quoteUSD(
            IUniswapV3Pool(0xCBCdF9626bC03E24f779434178A73a0B4bad62eD), 257220, 257820, 644350055919596, 1800, 1 days
        );
        console.log("valueUSD", valueUSD);
    }

    function test_quoteUSD_frxETHETH() public view {
        uint256 valueUSD = oracle.quoteUSD(
            IUniswapV3Pool(0x8a15b2Dc9c4f295DCEbB0E7887DD25980088fDCB),
            -20,
            20,
            19755028813714897209669,
            false,
            true,
            1800,
            1 days
        );
        console.log("valueUSD", valueUSD);
    }

    function test_bunniTokenPriceUSD_frxETHETH() public view {
        uint256 priceUSD = oracle.bunniTokenPriceUSD(
            IBunniToken(0xefFe49D9fCe8A4fC71Be42f7b2A83Bd353107Be3), false, true, 1800, 1 days
        );
        console.log("priceUSD", priceUSD);
    }

    function test_bunniTokenPriceUSD_FRAXUSDC() public view {
        uint256 priceUSD =
            oracle.bunniTokenPriceUSD(IBunniToken(0x088DCFE115715030d441a544206CD970145F3941), 1800, 1 days);
        console.log("priceUSD", priceUSD);
    }
}
