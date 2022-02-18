// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
import "./FundraiserHandler.sol";
import "./FunderHandler.sol";

contract CrowdFunding is FundraiserHandler, FunderHandler {
  function getBalance() public view returns (uint256) {
    return address(this).balance;
  }
}