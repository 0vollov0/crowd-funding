// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract CrowdFundingFactory {
    using SafeMath for uint256;

    event CreateFunding(uint id, string title, address owner);

    // It will check whether funding beginning time is past now
    modifier fundingBeginMustBePassedNow(uint _fundingBegin) {
        require(block.timestamp <= _fundingBegin);
        _;
    }

    struct Funding {
        string title;
        string subTitle;
        string comments;
        uint currentAmount;
        uint availableMinAmount;
        uint goalAmount;
        uint fundingBegin;
        uint fundingEnd;
        address seller;
    }

    Funding[] public fundings;

    mapping (uint=>address) public fundingToSeller;
    mapping (address=>uint[]) public addressToFundingIds;

    function createFunding(
        string memory _title,
        string memory _subTitle,
        string memory _comments,
        uint _goalAmount,
        uint _availableMinAmount,
        uint _fundingBegin,
        uint _fundingEnd) external returns(uint) {
        fundings.push(
            Funding(_title, _subTitle, _comments, 0, _availableMinAmount, _goalAmount, _fundingBegin, _fundingEnd, msg.sender)
        );

        uint id = fundings.length.sub(1);
        fundingToSeller[id] = msg.sender;
        addressToFundingIds[msg.sender].push(id);
        emit CreateFunding(id, _title, msg.sender);
        return id;
    }

    function getMyFundingList() external view returns(Funding [] memory) {
        uint[] memory fundingIds = addressToFundingIds[msg.sender];
        Funding[] memory myFundings = new Funding[](fundingIds.length);
        for(uint i=0; i < fundingIds.length; i.add(1)) {
            myFundings[i] = fundings[fundingIds[i]];
        }
        return myFundings;
    }

    function getFundings() external view returns(Funding [] memory) {
        return fundings;
    }
}