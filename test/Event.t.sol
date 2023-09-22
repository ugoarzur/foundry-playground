// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.21;

import "forge-std/Test.sol";
import {Event} from "../src/Event.sol";

contract EventTest is Test {
    Event public e;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    function setUp() public {
        e = new Event();
    }
    // Test should pass as long as the event and function are sharing
    // the same interface and values.

    function testEmitTransferEvent() public {
        // Asking vm to compare 1, 2 first arguments, not 3 and compare the rest of data.
        vm.expectEmit(true, true, false, true);
        // Tell Foundry that the next Tranfer event will be emitted like this
        emit Transfer(address(this), address(123), 456);
        // Calling transfer() method (to emit the Transfer event)
        e.transfer(address(this), address(123), 456);
    }
    // Test Should fail with another address

    function testFailEmitTransferEvent() public {
        // Asking vm to compare 1, 2 first arguments, not 3 and compare the rest of data.
        vm.expectEmit(true, true, false, true);
        // Tell Foundry that the next Tranfer event will be emitted like this
        emit Transfer(address(this), address(123), 456);
        // Calling transfer() method (to emit the Transfer event)
        e.transfer(address(this), address(124), 456);
    }

    // Test Should pass event with different values because we only check 1rst arg
    function testEmitTransferEventDiffValue() public {
        vm.expectEmit(true, false, false, false);
        emit Transfer(address(this), address(123), 456);
        e.transfer(address(this), address(200), 321);
    }

    function testEmitManyTransferEvent() public {
        // Building array of addresses
        address[] memory to = new address[](2);
        to[0] = address(123);
        to[1] = address(456);

        // Building array of amounts
        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 777;
        amounts[1] = 888;

        for (uint256 i = 0; i < to.length; i++) {
            // 1. Tell Foundry which data to check
            vm.expectEmit(true, true, false, true);
            // 2. Emit the expected event
            emit Transfer(address(this), to[i], amounts[i]);
        }
        // 3. Call the function that should emit the event
        e.transferMany(address(this), to, amounts);
    }
}
