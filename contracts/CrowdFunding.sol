// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;
import "./FundraiserHandler.sol";
import "./FunderHandler.sol";

contract CrowdFunding is FundraiserHandler, FunderHandler {
  function getBalance() public view returns (uint256) {
    return address(this).balance;
  }

  function getFundings() external view returns(Funding [] memory) {
      return fundings;
  }

  function getFunding(uint _fundingId) external view returns(Funding memory) {
    return fundings[_fundingId];
  }
}
