// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;
import {WakandaRouter} from "../src/swap/Router.sol";

import {WakandaFactory} from "../src/swap/Wakanda_pair.sol";

import "forge-std/Script.sol";

contract SwapDeployment is Script {
    WakandaFactory wkFactory;
    WakandaRouter wkRouter;
    address WBNB = 0xae13d989daC2f0dEbFf460aC112a837C89BAa7cd;

    function setUp() public {}

    function run() public {
        vm.broadcast();
        wkFactory = new WakandaFactory();
        vm.stopBroadcast();
        vm.broadcast();
        wkRouter = new WakandaRouter(address(wkFactory), WBNB);
        vm.stopBroadcast();
    }
}
