// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./CrowdFundingFactory.sol";

contract CrowdFundingInvestment is CrowdFundingFactory {
    
    using SafeMath for uint256;

    event Invest(address _address, uint _fundingId, uint amount, uint date);

    modifier availableAmount(uint _fundingId) {
        require(fundings[_fundingId].availableMinAmount <= msg.value);
        _;
    }

    modifier availableFundingTime(uint _fundingId) {
        uint time = block.timestamp;
        require(fundings[_fundingId].fundingBegin <= time && time < fundings[_fundingId].fundingEnd);
        _;
    }

    struct AccountPaper {
        address funder;
        uint fundingId;
        uint amount;
        uint date;
    }

    mapping (uint=>AccountPaper[]) public fundingToAccountPapers;
    mapping (address=>uint[]) public addressToInvestedFundingIds;
    mapping (address=>mapping(uint=>uint[])) public addressToFundingIdToAcoountPapersIds;
    // mapping (address=>mapping(uint=>AccountPaper[])) public addressToFundingIdToAccountPapers;

    function invest(uint _fundingId) external payable availableFundingTime(_fundingId) availableAmount(_fundingId){
        uint date = block.timestamp;
        uint investAmount = msg.value;
        fundings[_fundingId].currentAmount.add(investAmount);
        AccountPaper memory accountPaper = AccountPaper(msg.sender, _fundingId, investAmount, date);
        fundingToAccountPapers[_fundingId].push(accountPaper);
        addressToInvestedFundingIds[msg.sender].push(_fundingId);
        addressToFundingIdToAcoountPapersIds[msg.sender][_fundingId].push(fundingToAccountPapers[_fundingId].length.sub(1));
        emit Invest(msg.sender, _fundingId, investAmount, date);
    }

    function getMyFundingAccountPapers(uint _id) external view returns(AccountPaper[] memory){
        uint[] memory accountPaperIds = addressToFundingIdToAcoountPapersIds[msg.sender][_id];
        AccountPaper[] memory FundingAccountPapers = fundingToAccountPapers[_id];
        AccountPaper[] memory myAccountPapers = new AccountPaper[](accountPaperIds.length);

        for(uint i=0; i < accountPaperIds.length; i.add(1)) {
            myAccountPapers[i] = FundingAccountPapers[accountPaperIds[i]];
        }

        return myAccountPapers;
    }
}