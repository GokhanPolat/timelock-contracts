// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MockERC20 is ERC20 {
  address private immutable _timelock;

  constructor(
    string memory name_,
    string memory symbol_,
    address timelock_
  ) ERC20(name_, symbol_) {
    _timelock = timelock_;
  }

  modifier onlyTimelock() {
    require(msg.sender == _timelock, "onlyTimelock");
    _;
  }

  // solhint-disable no-empty-blocks
  receive() external payable {}

  function mint(address account, uint256 amount) public payable onlyTimelock {
    _mint(account, amount);
  }

  function burn(address account, uint256 amount) public onlyTimelock {
    _burn(account, amount);
  }
}
