// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;
import "./SafeMath.sol";

contract FundingFactory {
    using SafeMath for uint256;

    event CreateFunding(uint id, string title, address owner, uint goalAmount, uint beginTime, uint endTime);

    uint coinUnit = 1 wei;

    struct Funding {
        string title;
        string subTitle;
        string content;
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
        string memory _content,
        uint _goalAmount,
        uint _availableMinAmount,
        uint _beginTime,
        uint _endTime) external returns(uint) {
        require(block.timestamp < _beginTime, "The beginTime must be after block timestamp.");
        require(_beginTime < _endTime, "The beginTime must be before the endTime.");
        require(_goalAmount > _availableMinAmount,"The goalAmount must be upper than availableMinAmount.");
        fundings.push(
            Funding(_title, _subTitle, _content, 0, _availableMinAmount * coinUnit, _goalAmount, _beginTime, _endTime, msg.sender)
        );
        uint id = fundings.length.sub(1);
        fundingToFundraiser[id] = msg.sender;
        addressToFundingIds[msg.sender].push(id);
        emit CreateFunding(id, _title, msg.sender, _goalAmount, _beginTime, _endTime);
        return id;
    }
}
