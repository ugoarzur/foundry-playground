// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.21;

contract Error {
    error NotAuthorized();

    // Function can be called from another contract
    function throwError() external pure {
        require(false, "not authorized");
    }

    function throwCustomError() external pure {
        revert NotAuthorized();
    }
}
