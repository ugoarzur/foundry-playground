pragma solidity ^0.8.21;

import "forge-std/Test.sol";
import {Auction} from "../src/Auction.sol";

contract TimeTest is Test {
  Auction public auction;
  uint256 private startAt;


  // vm.warp - set block.timestamp to future timestamp
  // vm.roll - set block number
  // skip - increment current timestamp
  // rewind - decrement current timestamp

  function setUp() public {
    auction = new Auction();
    startAt = block.timestamp;
  }

  function testBidFailsBeforeStartTime() public {
    // Auction should fail because of startAt = block.timestamp + 1 days in Auction.sol
    vm.expectRevert(bytes("cannot bid"));
    auction.bid();
  }

  function testBid() public {
    // vm.warp() simulate a future timestamp, so auction.bid() is a success
    vm.warp(startAt + 1 days);
    auction.bid();
  }

  function testBidFailsAfterEndTime() public {
    vm.expectRevert("cannot bid");
    // vm.warp() simulate a block when auction has ended.
    vm.warp(startAt + 2 days);
    auction.bid();
  }

  // No need for Auction.sol for the rest

  function testTimestamp() public {
    uint savedTimestamp = block.timestamp;

    // skip - increment current timestamp (in seconds)
    skip(100);
    // Verify the block.timestamp to match the skip modification
    assertEq(block.timestamp, savedTimestamp + 100);

    // rewind - decrement current timestamp
    rewind(10);
    // Verify the block.timestamp to match the skip and rewind modification
    assertEq(block.timestamp, savedTimestamp + 100 - 10);
  }
  function testBlockNumber() public {
    // vm.roll - set block.number
    assertEq(block.number, 1);
    vm.roll(999);
    assertEq(block.number, 999);
  }
}
