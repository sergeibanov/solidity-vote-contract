## Vote Contract Overview

This particular repo is the result of the second task assigned by Chat GPT. I provided the whole idea of the "Solidity Chat GPT Test Tasks Project" [in this repo](https://github.com/sergeibanov/solidity-chatGPT-task-contract). Feel free to read it. Below is the task description provided by Chat GPT:

## Task Description

**Title**: Development of a Confidential Voting Smart Contract

**Objective**: Create a Solidity smart contract to facilitate a confidential voting process where participants can register and vote for proposed options, ensuring that each participant can vote only once.

**Requirements**:

- **Data Structure**:
  - `Voter` Structure with fields:
    - `address voterAddress` (address of the participant)
    - `bool hasVoted` (flag indicating whether the participant has voted)
  
  - `Proposal` Structure with fields:
    - `string description` (description of the proposal)
    - `uint256 voteCount` (number of votes for the proposal)

- **Variables**:
  - List of participants.
  - List of proposals.
  - Voting state (active or not).

- **Functions**:
  - `startVoting()` - to start the voting process. Only the contract owner can start the voting.
  - `endVoting()` - to end the voting process. Only the contract owner can end the voting.
  - `registerVoter()` - for registering a participant. Participants can register themselves.
  - `vote(uint256 proposalIndex)` - to allow a participant to vote for one of the proposals.
  - `getWinner()` - to return the proposal with the most votes.

- **Constraints**:
  - A participant can vote only once.
  - Voting can be initiated and concluded only by the contract owner.
  - Voting results should be visible only after its conclusion.

- **Additional Points**:
  - Implementation of a function that allows participants to delegate their vote to another participant.
  - Use of events for logging important actions in the contract (for example, when a participant votes or registers).
  - Implementation of modifiers for functions that require certain conditions to be met (for example, only the owner can start voting).

- **Evaluation Criteria**:
  - Correct implementation of voting logic.
  - Adherence to all requirements and constraints.
  - Cleanliness and readability of code.
  - Proper handling of potential errors and exceptions.
  - Efficiency and code optimization.
