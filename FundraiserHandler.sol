// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./FundingHandler.sol";

contract FundraiserHandler is FundingHandler {
    using SafeMath for uint256;

    function setAvailableMinAmount(uint _fundingId, uint _availableMinAmount) external ownerOfFunding(_fundingId) {
        fundings[_fundingId].availableMinAmount = _availableMinAmount;
    }

    function withdrawAsFundraiser(address payable _address, uint _fundingId) external fundingSucceeded(_fundingId) {
        bool success = _transfer(_address, fundings[_fundingId].currentAmount);
        if(success) fundings[_fundingId].currentAmount = 0;
    }
}