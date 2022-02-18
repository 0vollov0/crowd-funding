// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract FundingCoinManager {
  function _transfer(address payable _address, uint _amount) internal {
      require(_address == msg.sender);
      (bool sent, ) = _address.call{value: _amount}("");
      require(sent, "Failed to send Ether");
  }
}