// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./CrowdFundingFactory.sol";
import "./FundingCoinManager.sol";

contract FundraiserHandler is CrowdFundingFactory, FundingCoinManager {
    using SafeMath for uint256;

    function setFudingOpenState(uint _fundingId, bool _flag) external ownerOfFunding(_fundingId) {
        if (fundings[_fundingId].open != _flag) fundings[_fundingId].open = _flag;
    }

    function setAvailableMinAmount(uint _fundingId, uint _availableMinAmount) external ownerOfFunding(_fundingId) {
        fundings[_fundingId].availableMinAmount = _availableMinAmount;
    }

    function withdraw(address payable _address, uint _fundingId) external {
        require(fundings[_fundingId].fundraiser == msg.sender);
        require(fundings[_fundingId].goalAmount <= fundings[_fundingId].currentAmount);
        require(fundings[_fundingId].endTime <= block.timestamp);
        _address.transfer(fundings[_fundingId].currentAmount);
        fundings[_fundingId].currentAmount = 0;
        fundings[_fundingId].open = false;
    }
}