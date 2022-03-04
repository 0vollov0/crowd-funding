// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;
import "./FundingHandler.sol";

contract FunderHandler is FundingHandler {
    
    using SafeMath for uint256;

    event Fund(address funder, uint fundingId, uint amount, uint time);
    event WithdrawAsFunder(address funder, uint amount, uint time);

    modifier funded(uint _fundingId) {
        require(addressToFundingIdToAcoountPapersIds[msg.sender][_fundingId].length > 0);
        _;
    }

    modifier ownerOfAccountPaper(uint _fundingId, uint _accountPaperId) {
        require(fundingToAccountPapers[_fundingId][_accountPaperId].funder == msg.sender);
        _;
    }

    struct AccountPaper {
        address funder;
        uint fundingId;
        uint amount;
        uint date;
    }

    mapping (uint=>AccountPaper[]) public fundingToAccountPapers;
    mapping (address=>uint[]) public addressToFundedFundingIds;
    mapping (address=>mapping(uint=>uint[])) public addressToFundingIdToAcoountPapersIds;

    function fund(uint _fundingId) external payable availableFund(_fundingId) { 
        uint time = block.timestamp;
        uint fundAmount = msg.value;
        fundings[_fundingId].currentAmount = fundings[_fundingId].currentAmount.add(fundAmount);
        AccountPaper memory accountPaper = AccountPaper(msg.sender, _fundingId, fundAmount, time);
        fundingToAccountPapers[_fundingId].push(accountPaper);
        addressToFundedFundingIds[msg.sender].push(_fundingId);
        addressToFundingIdToAcoountPapersIds[msg.sender][_fundingId].push(fundingToAccountPapers[_fundingId].length.sub(1));
        emit Fund(msg.sender, _fundingId, fundAmount, time);
    }

    function withdrawAsFunder(uint _fundingId) external funded(_fundingId) fundingInProgressOrFailed(_fundingId) {
        require(addressToFundingIdToAcoountPapersIds[msg.sender][_fundingId].length > 0, "You don't have any account paper about the funding.");
        uint fundedAmount;
        uint accountPaperLength = addressToFundingIdToAcoountPapersIds[msg.sender][_fundingId].length;
        for (uint i = 0; i < accountPaperLength; i++) {
           fundedAmount = fundedAmount.add(_popAccountPaperAmount(_fundingId));
        }
        fundings[_fundingId].currentAmount = fundings[_fundingId].currentAmount.sub(fundedAmount);
        bool success = withdraw(fundedAmount);
        require(success,"withdraw method doesn't work well.");
        emit WithdrawAsFunder(msg.sender, fundedAmount, block.timestamp);
    }

    function getMyFundingAccountPapers(uint _fundingId) external view returns(AccountPaper[] memory){
        uint[] memory accountPaperIds = addressToFundingIdToAcoountPapersIds[msg.sender][_fundingId];
        AccountPaper[] memory FundingAccountPapers = fundingToAccountPapers[_fundingId];
        AccountPaper[] memory myAccountPapers = new AccountPaper[](accountPaperIds.length);

        for(uint i=0; i < accountPaperIds.length; i++) {
            myAccountPapers[i] = FundingAccountPapers[accountPaperIds[i]];
        }

        return myAccountPapers;
    }

    function _popAccountPaperAmount(uint _fundingId) private returns(uint) {
        require(addressToFundingIdToAcoountPapersIds[msg.sender][_fundingId].length > 0);
        uint accountPaperId = addressToFundingIdToAcoountPapersIds[msg.sender][_fundingId][0];
        uint amount = fundingToAccountPapers[_fundingId][accountPaperId].amount;
        _removeMyAccountPaperIds(_fundingId, 0);
        return amount;
    }

    function _removeMyAccountPaperIds(uint _fundingId, uint _index) private {
        require(_index < addressToFundingIdToAcoountPapersIds[msg.sender][_fundingId].length, "index out of bound");

        for (uint i = _index; i < addressToFundingIdToAcoountPapersIds[msg.sender][_fundingId].length - 1; i++) {
            addressToFundingIdToAcoountPapersIds[msg.sender][_fundingId][i] = addressToFundingIdToAcoountPapersIds[msg.sender][_fundingId][i + 1];
        }
        addressToFundingIdToAcoountPapersIds[msg.sender][_fundingId].pop();
    }
}
