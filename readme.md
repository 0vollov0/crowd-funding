 Contracts Description Table


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


 Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
