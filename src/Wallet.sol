// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Wallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function withdraw(uint _amount) external {
        require(msg.sender == owner, "caller is not owner");
        payable(msg.sender).transfer(_amount);
    }

    function setOwner(address _owner) external {
      require(msg.sender == owner, "caller is not owner");
      owner = payable(_owner);
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
