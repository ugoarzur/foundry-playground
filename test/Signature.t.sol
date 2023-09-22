pragma solidity ^0.8.21;

import "forge-std/Test.sol";

contract SignatureTest is Test {
    // private key = 123;
    // public key = vm.address(private key)
    // message = "secret message"
    // message hash = keccak256(message)
    // vm.sign(private key, message hash)

    function testSignature() public {
        // create keys
        uint256 privatekey = 123;
        address publickey = vm.addr(privatekey);

        // hash the secret message and sign it with privatekey
        bytes32 messageHash = keccak256("Secret message");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privatekey, messageHash);

        // recovering the signer with proofs signature parts and hashed message
        address signer = ecrecover(messageHash, v, r, s);
        assertEq(signer, publickey);
    }
}
