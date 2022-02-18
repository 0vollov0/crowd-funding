// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
contract CrowdFundingFactory {
    using SafeMath for uint256;

    event CreateFunding(uint id, string title, address owner);

    uint coinUnit = 1 wei;

    modifier beginFunding(uint _fundingId) {
        require(block.timestamp <= fundings[_fundingId].beginTime);
        _;
    }

    modifier endFunding(uint _fundingId) {
        require(fundings[_fundingId].endTime < block.timestamp);
        _;
    }

    modifier availableFunding(uint _fundingId) {
        uint time = block.timestamp;
        require(fundings[_fundingId].beginTime < time,"The funding not open yet.");
        require(time < fundings[_fundingId].endTime,"The funding closed.");
        _;
    }

    modifier ownerOfFunding(uint _fundingId) {
        require(msg.sender == fundings[_fundingId].fundraiser);
        _;
    }

    modifier availableAmount(uint _fundingId) {
        require(fundings[_fundingId].availableMinAmount * coinUnit <= msg.value);
        _;
    }

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
        bool open;
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
            Funding(_title, _subTitle, _comments, 0, _availableMinAmount * coinUnit, _goalAmount, _beginTime, _endTime, msg.sender, true)
        );
        // require(block.timestamp < _beginTime, "The beginTime must be after block timestamp.");
        require(_beginTime < _endTime, "The beginTime must be before the endTime.");
        uint id = fundings.length.sub(1);
        fundingToFundraiser[id] = msg.sender;
        addressToFundingIds[msg.sender].push(id);
        emit CreateFunding(id, _title, msg.sender);
        return id;
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