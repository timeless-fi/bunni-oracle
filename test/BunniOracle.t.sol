// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.4;

import "forge-std/Test.sol";

import "solmate/utils/LibString.sol";

import "../src/BunniOracle.sol";

contract BunniOracleTest is Test {
    using LibString for uint256;

    FeedRegistryInterface immutable CHAINLINK = FeedRegistryInterface(_getEnvAddressForNetwork("CHAINLINK"));
    AggregatorV2V3Interface immutable SEQUENCER_UPTIME =
        AggregatorV2V3Interface(_getEnvAddressForNetwork("SEQUENCER_UPTIME"));
    address immutable WETH = _getEnvAddressForNetwork("WETH");
    address immutable WBTC = _getEnvAddressForNetwork("WBTC");
    address immutable USDC = _getEnvAddressForNetwork("USDC");
    address immutable USDT = _getEnvAddressForNetwork("USDT");
    address immutable DAI = _getEnvAddressForNetwork("DAI");
    address immutable FRAX = _getEnvAddressForNetwork("FRAX");
    BunniOracle oracle;

    function setUp() public {
        oracle = new BunniOracle(CHAINLINK, SEQUENCER_UPTIME, WETH, WBTC, USDC, USDT, DAI, FRAX);
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

    function test_quoteUSD_tBTCWBTC() public view {
        uint256 valueUSD = oracle.quoteUSD(
            IUniswapV3Pool(0xdBAc78BE00503d10ae0074e5E5873a61fc56647c),
            -230630,
            -230340,
            716679363107741,
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

    function _getEnvAddressForNetwork(string memory name) internal view returns (address) {
        return vm.envAddress(string.concat(name, "_", block.chainid.toString()));
    }
}
