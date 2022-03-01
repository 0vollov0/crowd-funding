// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;
// import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";
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
        require(time < fundings[_fundingId].endTime,"The funding closed.");
        require(fundings[_fundingId].availableMinAmount * coinUnit <= msg.value, "You need to use more amount. Check the funding minimun amount.");
        _;
    }

    modifier ownerOfFunding(uint _fundingId) {
        require(msg.sender == fundings[_fundingId].fundraiser);
        _;
    }

    modifier fundingNotEndOrFailed(uint _fundingId) {
        uint time = block.timestamp;
        bool notEndFunding = (fundings[_fundingId].beginTime < time && time < fundings[_fundingId].endTime);
        bool failedFunding =  (fundings[_fundingId].endTime < time) && (fundings[_fundingId].goalAmount < fundings[_fundingId].currentAmount);
        require(notEndFunding || failedFunding,"The funding time has passed or has not been successful.");
        _;
    }

    modifier fundingSucceeded(uint _fundingId) {
        require(fundings[_fundingId].fundraiser == msg.sender);
        require(fundings[_fundingId].goalAmount <= fundings[_fundingId].currentAmount);
        require(fundings[_fundingId].endTime <= block.timestamp);
        _;
    }

    function getMyFundingList() external view returns(Funding [] memory) {
        uint[] memory fundingIds = addressToFundingIds[msg.sender];
        Funding[] memory myFundings = new Funding[](fundingIds.length);
        for(uint i=0; i < fundingIds.length; i++) {
            myFundings[i] = fundings[fundingIds[i]];
        }
        return myFundings;
    }

    function getFundings() external view returns(Funding [] memory) {
        return fundings;
    }
}
