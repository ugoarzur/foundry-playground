// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.21;

contract Event {
  event Transfer(address indexed from, address indexed to, uint256 amount);

  // Function can be called from another contract
  function transfer(address _from, address _to, uint256 _amount) external {
    emit Transfer(_from, _to, _amount);
  }

  function transferMany(address _from, address[] calldata _to, uint256[] calldata _amounts) external {
    for (uint256 i = 0; i < _to.length; i++) {
      emit Transfer(_from, _to[i], _amounts[i]);
    }
  }
}
