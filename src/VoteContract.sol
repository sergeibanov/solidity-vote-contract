// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract VoteContract {
    address public owner;

    struct Voter {
        address voterAddress;
        bool hasVoted;
        uint256 voterId;
    }

    struct Proposal {
        string description;
        uint256 numberOfVotes;
        uint256 proposalId;
    }

    uint256 private proposalId = 0;  
    uint256 private voterId = 0; 

    // I know that using mapping is more gas efficient, but specifically in this task I decided to understand how Array works.
    Voter [] public listOfVoters;
    Proposal [] public listOfProposals;

    bool votingActive;

    event VoterHasVoted(address indexed voterAddress, uint256 voterId, uint256 proposalId);
    event VoterHasRegistered(address indexed voterAddress, uint256 voterId);
    event ProposalHasBeenCreated(string description, uint256 proposalId);

    constructor () {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    function startVoting() public onlyOwner returns (bool) {
        votingActive = true;
        return true;
    }

    function endVoting() public onlyOwner returns (bool) {
        votingActive = false;
        return false;
    }

    function statusOfVoting() public view returns (bool) {
        return votingActive;
    }

    modifier onlyVotingActive {
        require(votingActive == true, "Voting has not started yet");
        _;
    }

    modifier onlyVotingFinished {
        require(votingActive == false, "Voting still in progress");
        _;
    }

    function registerVoter(address _voterAdress) public {
        Voter memory newVoter = Voter({
            voterAddress: _voterAdress,
            voterId: voterId++,
            hasVoted: false
        });
        listOfVoters.push(newVoter);

        emit VoterHasRegistered(_voterAdress, newVoter.voterId);
    }

    function registerProposal(string memory _description) public {
        Proposal memory newProposal = Proposal({
            description: _description,
            proposalId: proposalId++,
            numberOfVotes: 0
        });

        listOfProposals.push(newProposal);

        emit ProposalHasBeenCreated(_description, newProposal.proposalId);
    }

    function vote(uint256 _voterId, uint256 _proposalId) public onlyVotingActive  {
        require(msg.sender == listOfVoters[_voterId].voterAddress && listOfVoters[_voterId].hasVoted == false, 
        "Not the registered voter or this voter has already voted");

        listOfProposals[_proposalId].numberOfVotes ++;
        listOfVoters[_voterId].hasVoted = !listOfVoters[_voterId].hasVoted;

        emit VoterHasVoted(msg.sender, _voterId, _proposalId);
    }

    function getWinner() public view onlyVotingFinished returns (Proposal memory)  {
        uint256 maxVotes = 0;
        Proposal memory winner;
 
        for (uint i = 0; i < listOfProposals.length; i++) {
            if (listOfProposals[i].numberOfVotes > maxVotes) {
                maxVotes = listOfProposals[i].numberOfVotes;
                winner = listOfProposals[i];
            }
        }

        return winner;
    }

    function getProposals() public view returns (Proposal [] memory){
        return listOfProposals;
    }

    function getVoters() public view returns (Voter [] memory){
        return listOfVoters;
    }


    function deligateVote(uint256 _voterId, address _newVoter) public  returns (address){
        require(msg.sender == listOfVoters[_voterId].voterAddress && listOfVoters[_voterId].hasVoted == false, 
        "Not the registered voter or this voter has already voted");

        listOfVoters[_voterId].voterAddress = _newVoter;
        return _newVoter;
    }
}