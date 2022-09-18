// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.12;

import "../src/farm/GenericStakeFactory.sol";

import "forge-std/Script.sol";

contract WKDStake is Script {
    address WKD = 0x5344C20FD242545F31723689662AC12b9556fC3d;
    uint256 constant wkdPerBlock = 154_320e9;
    GenericStakeFactory gFactory;

    function setUp() public {}

    function run() public {
        vm.broadcast();
        gFactory = new GenericStakeFactory();
        vm.stopBroadcast();
        vm.broadcast();
        gFactory.deployPool(
            IBEP20(WKD),
            IBEP20(WKD),
            wkdPerBlock,
            block.number,
            block.number + 280_000, //10 days
            0,
            tx.origin
        );
        vm.stopBroadcast();
    }
}
