// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./CrowdFundingFactory.sol";

contract CrowdFundingInvestment is CrowdFundingFactory {
    
    using SafeMath for uint256;

    event Invest(address _address, uint _fundingId, uint amount, uint date);

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

    function invest(uint _id, uint _amount) external {
        uint date = block.timestamp;
        AccountPaper memory accountPaper = AccountPaper(msg.sender, _id, _amount, date);
        fundingToAccountPapers[_id].push(accountPaper);
        addressToInvestedFundingIds[msg.sender].push(_id);
        addressToFundingIdToAcoountPapersIds[msg.sender][_id].push(fundingToAccountPapers[_id].length.sub(1));
        emit Invest(msg.sender, _id, _amount, date);
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