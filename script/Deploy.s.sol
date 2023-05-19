// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.13;

import {CREATE3Script} from "./base/CREATE3Script.sol";
import {UniV3LpOracle} from "../src/UniV3LpOracle.sol";

contract DeployScript is CREATE3Script {
    constructor() CREATE3Script(vm.envString("VERSION")) {}

    function run() external returns (UniV3LpOracle c) {
        uint256 deployerPrivateKey = uint256(vm.envBytes32("PRIVATE_KEY"));

        vm.startBroadcast(deployerPrivateKey);

        address chainlink = vm.envAddress("CHAINLINK");
        address WETH = vm.envAddress("WETH");
        address WBTC = vm.envAddress("WBTC");
        address USDC = vm.envAddress("USDC");
        address USDT = vm.envAddress("USDT");
        address DAI = vm.envAddress("DAI");
        address FRAX = vm.envAddress("FRAX");
        c = UniV3LpOracle(
            create3.deploy(
                getCreate3ContractSalt("UniV3LpOracle"),
                bytes.concat(type(UniV3LpOracle).creationCode, abi.encode(chainlink, WETH, WBTC, USDC, USDT, DAI, FRAX))
            )
        );

        vm.stopBroadcast();
    }
}
