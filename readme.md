# crowd-funding

This is a program that is crowdfunding which is able to operate in Ethereum network. There are two type  of users in this contract, The first one is a `Funder` who fund for funding success. The second one is a `Fundraiser` who create a funding for his project.

When `Fundraiser` create a funding, he needs to set up title, subtitle, content, goalAmount, minAvailableAmount, beginTime, endTime about his funding.

In order to withdraw Ether from a funding as `Fundraiser`, You need a successful funding that stored in this smart contract.

In order to withdraw Ether from a funding as `Funder`, A funding state must be failed or progress.

> getBalance method that is located in crowdFunding would show you balance of this contract.

## Test Publish
|Network|Contract|Txn Hash|Block|
|---|---|---|---|
|[Ropsten](https://ropsten.etherscan.io/address/0xA0A5B8867D21BD4d7fA8119c84D8CB36a84e45f2)|0xA0A5B8867D21BD4d7fA8119c84D8CB36a84e45f2|[0xdfe79ac00610feb29dc25aa516e91da1f1146244cdd5b2ad71cfcad24235cad3](https://ropsten.etherscan.io/tx/0xdfe79ac00610feb29dc25aa516e91da1f1146244cdd5b2ad71cfcad24235cad3)|[12042051](https://ropsten.etherscan.io/block/12042051)|


## Contracts UML

![UML](./uml/solidity_uml.png)

## Contracts Description Table

|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|          |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
| **CrowdFunding** | ***Implementation*** | FundraiserHandler, FunderHandler |||
| L  | getBalance | Public ❗️  |   |NO❗️ |
| **FundraiserHandler** | ******Implementation****** | FundingHandler |||
|  L | setAvailableMinAmount | External ❗️ | 🛑  | ownerOfFunding |
|  L | withdrawAsFundraiser | External ❗️ | 🛑  | fundingSucceeded |
| **FundingHandler** | ***Implementation*** | FundingFactory, FundingCoinManager |||
 | L  | getMyFundingList | External ❗️  |   |NO❗️ |
 | L  | getFundings | External ❗️  |  |NO❗️ |
| **FundingFactory** | ***Implementation*** |  |||
 | L  | createFunding | External ❗️ | 🛑  |NO❗️ |
| **FundingCoinManager** | ***Implementation*** |  |||
 | L  | _transfer | Internal 🔒 | 🛑  | |
| **FunderHandler** | ***Implementation*** | FundingHandler |||
| L  | fund | External ❗️ |  💵 | availableFund |
| L  | withdrawAsFunder | External ❗️ | 🛑  | funded fundingNotEndOrFailed |
| L  | getMyFundingAccountPapers | External ❗️  |  |NO❗️ |
| L  | _popAccountPaperAmount | Private 🔐 | 🛑  | |
| L  | _removeMyAccountPaperIds | Private 🔐 | 🛑  | |


### Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
