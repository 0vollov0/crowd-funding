// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;
import "./FundingHandler.sol";

contract FundraiserHandler is FundingHandler {
    using SafeMath for uint256;

    event WithdrawAsFundraiser(address fundraiser, uint amount, uint time);

    function setAvailableMinAmount(uint _fundingId, uint _availableMinAmount) external ownerOfFunding(_fundingId) {
        require(_availableMinAmount > 0,"the availableMinAmount value must be upper than 0 wei.");
        fundings[_fundingId].availableMinAmount = _availableMinAmount;
    }

    function withdrawAsFundraiser(uint _fundingId) external fundingSucceeded(_fundingId) {
        bool success = withdraw(fundings[_fundingId].currentAmount);
        require(success,"withdraw method doesn't work well.");
        if(success) {
            emit WithdrawAsFundraiser(msg.sender, fundings[_fundingId].currentAmount, block.timestamp);
            fundings[_fundingId].currentAmount = 0;
        }
    }
}
