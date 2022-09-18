pragma solidity =0.8.0;

import "forge-std/Test.sol";

// import "../src/helpers/MOCKRWD.sol";
//import "../src/helpers/MockWKD.sol";

import "../src/farm/WKDPool.sol";
import "../src/poolHelpers/WakandaToken.sol";

contract WKDPoolTest is Test {
    WakandaToken wkdToken;
    WKDPool wkdPool;
    address user;
    address user2;
    address user3;

    function setUp() public {
        wkdToken = new WakandaToken("WAKANDA", "WKD");
        address admin = mkaddr("admin");
        address treasury = mkaddr("treasury");
        address operator = mkaddr("operator");
        user = mkaddr("user");
        user2 = mkaddr("user2");
        user3 = mkaddr("user3");
        wkdPool = new WKDPool(
            IERC20(address(wkdToken)),
            admin,
            treasury,
            operator
        );
    }

    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }

    function testStaking() public {
        vm.startPrank(user);
        //mint some tokens to pool
        //400billion
        wkdToken.mint(address(wkdPool), 400_000_000_000e18);

        // mint some tokens to self and user 2
        wkdToken.mint(user, 100_000_000e18);
        wkdToken.mint(user2, 100_000_000e18);
        wkdToken.mint(user3, 100_000_000e18);
        //approve pool
        wkdToken.approve(address(wkdPool), 400_000_000_000e18);
        //stake in normal pool
        wkdPool.deposit(100_000_000e18, 0);

        vm.stopPrank();
        vm.startPrank(user2);
        wkdToken.approve(address(wkdPool), 400_000_000_000e18);
        //stake in locked pool
        wkdPool.deposit(100_000_000e18, 2 weeks);
        vm.stopPrank();

        vm.startPrank(user3);
        wkdToken.approve(address(wkdPool), 400_000_000_000e18);
        //stake in normal pool
        wkdPool.deposit(100_000_000e18, 0);
        vm.stopPrank();
        // vm.warp(block.timestamp + 30 days);
        // vm.prank(user2);
        // wkdPool.userInfo(user);
        //   wkdPool.withdrawAll();

        // wkdPool.userInfo(user);
        // wkdPool.totalBoostDebt();
        wkdPool.totalStaticShares();
        vm.prank(user);
        wkdPool.withdrawAll();
        vm.warp(block.timestamp + 30 days);
        vm.prank(user2);
        wkdPool.withdrawAll();
        wkdToken.balanceOf(address(wkdPool)) / 1e18;
    }
}
