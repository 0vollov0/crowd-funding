// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

contract FundingCoinManager {
  function withdraw(uint _amount) internal returns(bool) {
    (bool success, ) = msg.sender.call{value: _amount}("");
    return success;
  }
}
