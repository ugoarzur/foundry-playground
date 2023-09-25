// SPDX-License-Identifier: Unlicence
pragma solidity ^0.8.21;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import {GaslessTokenTransfer} from "../src/app/GaslessTokenTransfer.sol";
import {ERC20Permit} from "../src/ERC20Permit.sol";

/// @title Gasless Token Transfer
/// @author Fabernovel - Ugo Arzur
/// @notice A smart contract to play around Gasless Transfers with a secure replay attack protection and gas optimization.
/// @dev Using Solmate ERC20 implementation is combining ERC-20 & EIP-2612.
/// @dev EIP-2612: token transfer approvals standard.
/// @dev EIP-712: typed structure data hashing & signing scheme.
contract GaslessTokenTransferTest is Test {
    ERC20Permit private token;
    GaslessTokenTransfer private gasless;

    uint256 constant SENDER_PRIVATE_KEY = 123;
    address sender;
    address receiver;
    uint256 constant AMOUNT = 100;
    uint256 constant FEE = 10;

    function setUp() public {
        sender = vm.addr(SENDER_PRIVATE_KEY);
        receiver = address(2);

        token = new ERC20Permit("test","test",18);
        token.mint(sender, AMOUNT + FEE);

        gasless = new GaslessTokenTransfer();
    }

    function testValidsig() public {
        uint256 deadline = block.timestamp + 60;
        // 1. Prepare permit message
        bytes32 permitHash = _getPermitHash(sender, address(gasless), AMOUNT + FEE, token.nonces(sender), deadline);

        // Signing the permitHash
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(SENDER_PRIVATE_KEY, permitHash);

        // 2. Execute send (to gas stocking contract)
        gasless.send(
          address(token),
          sender,
          receiver,
          AMOUNT,
          FEE,
          deadline,
          // Permit signature
          v, r, s
        );

        // 3. Check token balances
        // Checking sender balance = 0
        assertEq(token.balanceOf(sender), 0, "sender balance");
        assertEq(token.balanceOf(receiver), AMOUNT, "receiver balance");
        assertEq(token.balanceOf(address(this)), FEE, "fee balance");
    }

    function _getPermitHash(address owner, address spender, uint256 value, uint256 nonce, uint256 deadline)
        private
        view
        returns (bytes32)
    {
        return keccak256(
            abi.encodePacked(
                "\x19\x01",
                token.DOMAIN_SEPARATOR(),
                keccak256(
                    abi.encode(
                        keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
                        owner,
                        spender,
                        value,
                        nonce,
                        deadline
                    )
                )
            )
        );
    }
}
