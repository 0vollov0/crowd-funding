// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract CrowdFuncdingFactory {
    using SafeMath for uint256;

    event CreateFunding(uint id, string title, address owner);

    struct Funder {
        address funder;
        uint amount;
    }

    struct Fundindg {
        string title;
        string subTitle;
        string comments;
        uint goalAmount;
        uint32 fundingBegin;
        uint32 fundingEnd;
        address seller;
    }

    Fundindg[] public fundings;

    mapping (uint=>address) public fundingToSeller;
    mapping (uint=>Funder[]) public fundingToFunders;

    function createFundindg(
        string memory _title,
        string memory _subTitle,
        string memory _comments,
        uint _goalAmount,
        uint32 _fundingBegin,
        uint32 _fundingEnd) external returns(uint) {
        fundings.push(
            Fundindg(_title, _subTitle, _comments, _goalAmount, _fundingBegin, _fundingEnd, msg.sender)
        );

        uint id = fundings.length.sub(1);
        fundingToSeller[id] = msg.sender;
        emit CreateFunding(id, _title, msg.sender);
        return id;
    }
}