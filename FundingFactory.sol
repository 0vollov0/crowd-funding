// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
contract FundingFactory {
    using SafeMath for uint256;

    event CreateFunding(uint id, string title, address owner);

    uint coinUnit = 1 wei;

    struct Funding {
        string title;
        string subTitle;
        string comments;
        uint currentAmount;
        uint availableMinAmount;
        uint goalAmount;
        uint beginTime;
        uint endTime;
        address fundraiser;
    }

    Funding[] public fundings;

    mapping (uint=>address) public fundingToFundraiser;
    mapping (address=>uint[]) public addressToFundingIds;

    function createFunding(
        string memory _title,
        string memory _subTitle,
        string memory _comments,
        uint _goalAmount,
        uint _availableMinAmount,
        uint _beginTime,
        uint _endTime) external returns(uint) {
        fundings.push(
            Funding(_title, _subTitle, _comments, 0, _availableMinAmount * coinUnit, _goalAmount, _beginTime, _endTime, msg.sender)
        );
        require(block.timestamp < _beginTime, "The beginTime must be after block timestamp.");
        require(_beginTime < _endTime, "The beginTime must be before the endTime.");
        uint id = fundings.length.sub(1);
        fundingToFundraiser[id] = msg.sender;
        addressToFundingIds[msg.sender].push(id);
        emit CreateFunding(id, _title, msg.sender);
        return id;
    }
}