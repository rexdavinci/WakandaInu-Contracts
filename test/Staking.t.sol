// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import "forge-std/Test.sol";
import "../src/farm/GenericStakeFactory.sol";
import "../src/farm/GenericStake.sol";
import "../src/helpers/MOCKRWD.sol";
import "../src/helpers/MockWKD.sol";
import "../src/helpers/IBEP20.sol";

contract ContractTest is Test {
    GenericStakeFactory sFactory;
    MockREWARD mREWARD;
    MOCKWAKANDA mWAKANDA;

    function setUp() public {
        sFactory = new GenericStakeFactory();
        mWAKANDA = new MOCKWAKANDA();
        mREWARD = new MockREWARD();

        //create a pool

        address newPool = sFactory.deployPool(
            IBEP20(address(mWAKANDA)),
            IBEP20(address(mREWARD)),
            10e18,
            block.number + 10,
            block.number + 100,
            0,
            address(this)
        );

        mREWARD.setAddress(newPool);

        //try to stake some WKD
        mWAKANDA.approve(newPool, 10000e18);
        WakandaPoolInitializable pool = WakandaPoolInitializable(newPool);
        pool.deposit(100e18);
        address secondStaker = mkaddr("Second Staker");
        //send some WKD to another address
        mWAKANDA.transfer(secondStaker, 100e18);

        vm.prank(secondStaker);
        mWAKANDA.approve(newPool, 10000e18);
        vm.prank(secondStaker);
        pool.deposit(100e18);
        //check rewards
        pool.pendingReward(address(this));
        pool.pendingReward(secondStaker);

        //go to 50 blocks(40 blocks of reward)
        vm.roll(51);
        uint256 pending = pool.pendingReward(address(this));
        assertEq(pending, (10e18 * 40) / 2);
        pool.withdraw(400e18);
        pool.pendingReward(address(this));
        pool.withdraw(400e18);
    }

    function testExample() public {
        assertTrue(true);
    }

    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }
}
