// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.21;

import "lib/solmate/src/tokens/ERC20.sol";

contract Token is ERC20 ("name", "symbol", 18) {}
