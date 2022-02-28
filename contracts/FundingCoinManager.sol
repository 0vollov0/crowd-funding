// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

contract FundingCoinManager {
  function _transfer(address payable _address, uint _amount) internal returns(bool success) {
      require(_address == msg.sender);
      (bool sent, ) = _address.call{value: _amount}("");
      require(sent, "Failed to send Ether");
      return sent;
  }
}
