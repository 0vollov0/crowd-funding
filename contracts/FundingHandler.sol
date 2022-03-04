// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;
import "./FundingFactory.sol";
import "./FundingCoinManager.sol";

contract FundingHandler is FundingFactory, FundingCoinManager {
    using SafeMath for uint256;

    modifier beginFunding(uint _fundingId) {
        require(block.timestamp <= fundings[_fundingId].beginTime);
        _;
    }

    modifier endFunding(uint _fundingId) {
        require(fundings[_fundingId].endTime < block.timestamp);
        _;
    }

    modifier availableFund(uint _fundingId) {
        uint time = block.timestamp;
        require(fundings[_fundingId].beginTime < time,"The funding not open yet.");
        require(time < fundings[_fundingId].endTime,"The funding has closed.");
        require(fundings[_fundingId].availableMinAmount * coinUnit <= msg.value, "You need to fund more amount. Check the funding minimun amount.");
        _;
    }

    modifier ownerOfFunding(uint _fundingId) {
        require(msg.sender == fundings[_fundingId].fundraiser);
        _;
    }

    modifier fundingInProgressOrFailed(uint _fundingId) {
        uint time = block.timestamp;
        bool inProgress = (fundings[_fundingId].beginTime < time && time < fundings[_fundingId].endTime);
        bool failedFunding =  (fundings[_fundingId].endTime < time) && (fundings[_fundingId].currentAmount < fundings[_fundingId].goalAmount );
        require(inProgress || failedFunding,"The funding state must be progress or failed.");
        _;
    }

    modifier fundingSucceeded(uint _fundingId) {
        require(fundings[_fundingId].fundraiser == msg.sender);
        require(fundings[_fundingId].goalAmount <= fundings[_fundingId].currentAmount);
        require(fundings[_fundingId].endTime <= block.timestamp);
        _;
    }
}
