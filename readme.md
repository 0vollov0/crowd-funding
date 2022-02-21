 Contracts Description Table


|  Contract  |         Type        |       Bases      |                  |                 |
|:----------:|:-------------------:|:----------------:|:----------------:|:---------------:|
|          |  **Function Name**  |  **Visibility**  |  **Mutability**  |  **Modifiers**  |
||||||
| **CrowdFunding** | Implementation | FundraiserHandler, FunderHandler |||
|   | getBalance | Public ❗️ |   |NO❗️ |
||||||
| **FundraiserHandler** | Implementation | FundingHandler |||
|   | setAvailableMinAmount | External ❗️ | 🛑  | ownerOfFunding |
|   | withdrawAsFundraiser | External ❗️ | 🛑  | fundingSucceeded |
||||||
| **FundingHandler** | Implementation | FundingFactory, FundingCoinManager |||
|   | getMyFundingList | External ❗️ |   |NO❗️ |
|   | getFundings | External ❗️ |   |NO❗️ |
||||||
| **FundingFactory** | Implementation |  |||
|   | createFunding | External ❗️ | 🛑  |NO❗️ |
||||||
| **FundingCoinManager** | Implementation |  |||
|   | _transfer | Internal 🔒 | 🛑  | |
||||||
| **FunderHandler** | Implementation | FundingHandler |||
|   | fund | External ❗️ |  💵 | availableFund availableAmount |
|   | withdrawAsFunder | External ❗️ | 🛑  | funded fundingNotEndOrFailed |
|   | getMyFundingAccountPapers | External ❗️ |   |NO❗️ |
|   | _popAccountPaperAmount | Private 🔐 | 🛑  | |
|   | _removeMyAccountPaperIds | Private 🔐 | 🛑  | |


 Legend

|  Symbol  |  Meaning  |
|:--------:|-----------|
|    🛑    | Function can modify state |
|    💵    | Function is payable |
