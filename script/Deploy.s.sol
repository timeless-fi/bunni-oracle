// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.13;

import "solmate/utils/LibString.sol";

import {CREATE3Script} from "./base/CREATE3Script.sol";
import {BunniOracle} from "../src/BunniOracle.sol";

contract DeployScript is CREATE3Script {
    using LibString for uint256;

    constructor() CREATE3Script(vm.envString("VERSION")) {}

    function run() external returns (BunniOracle c) {
        uint256 deployerPrivateKey = uint256(vm.envBytes32("PRIVATE_KEY"));

        vm.startBroadcast(deployerPrivateKey);

        address chainlink = _getEnvAddressForNetwork("CHAINLINK");
        address sequencer_uptime = _getEnvAddressForNetwork("SEQUENCER_UPTIME");
        address WETH = _getEnvAddressForNetwork("WETH");
        address WBTC = _getEnvAddressForNetwork("WBTC");
        address USDC = _getEnvAddressForNetwork("USDC");
        address USDT = _getEnvAddressForNetwork("USDT");
        address DAI = _getEnvAddressForNetwork("DAI");
        address FRAX = _getEnvAddressForNetwork("FRAX");
        c = BunniOracle(
            create3.deploy(
                getCreate3ContractSalt("BunniOracle"),
                bytes.concat(
                    type(BunniOracle).creationCode,
                    abi.encode(chainlink, sequencer_uptime, WETH, WBTC, USDC, USDT, DAI, FRAX)
                )
            )
        );

        vm.stopBroadcast();
    }

    function _getEnvAddressForNetwork(string memory name) internal view returns (address) {
        return vm.envAddress(string.concat(name, "_", block.chainid.toString()));
    }
}
