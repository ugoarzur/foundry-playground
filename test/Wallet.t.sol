pragma solidity ^0.8.21;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {Wallet} from "../src/Wallet.sol";

// Examples of deal and hoax
// deal(address, uint) - set balance of address
// hoax(address, uint) - deal + prank, set up a prank and set balance

contract WalletTest is Test {
    Wallet public wallet;

    function setUp() public {
        // initiate Wallet with 1 ETH (1e18)
        wallet = new Wallet{value: 1e18}();
    }

    function _send(uint256 amount) private {
        // sending amount in ETH
        (bool ok,) = address(wallet).call{value: amount}("");
        require(ok, "send ETH failed");
    }

    function testEthBalance() public view {
        // ETH balance 79228162513
        console.log("ETH balance", address(this).balance / 1e18);
    }

    function testSendEth() public {
        uint256 balance = address(wallet).balance;

        deal(address(1), 100);
        assertEq(address(1).balance, 100);

        // deal is replacing 100 by 10, not an add() 100 -> 10
        deal(address(1), 10);
        assertEq(address(1).balance, 10);

        deal(address(1), 123);
        // calling prank to replace address(this) by address(1) for next call
        vm.prank(address(1));
        _send(123);

        hoax(address(1), 456);
        _send(456);

        assertEq(address(wallet).balance, balance + 123 + 456);
    }
}
