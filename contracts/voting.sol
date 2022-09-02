// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Voting {



    // Storing the list of candidates using an array of bytes32

    bytes32[] public CandidateList;   

    
    address Controller = msg.sender; 

    struct Voter {
        address VoterAddress;
        bool HasVoted;
        uint howManyVotesCanCast;
        
    }

    mapping (address => Voter) voter;
    mapping (bytes32 => uint) CandidateScore;

// Set Candidate name and add to array of candidates
    constructor(bytes32[] memory _candidateNames) {
        CandidateList = _candidateNames;

    }

// Verify Validity of Candidate to be voted
    function ValidCandidacy(bytes32 Candid) public returns(bool){

        for (uint i = 0; i < CandidateList.length; i++) {
            if (CandidateList[i] == Candid) {
                return true;               
            }
            
        }
        return false;

    }

    // Give voting right

    function giveVotingRight(address personToVote) public {
        require(msg.sender = Controller, "You can't grant anyone access to vote");
        require(!voter[personToVote].HasVoted, "You have already cast your vote");
        require(voter[personToVote].howManyVotesCanCast = 0, "You already have approval to vote");
        voter[personToVote].howManyVotesCanCast = 1;

    }

// Vote for a verified Candidate, increment their stats once valid
// Check if user is eligible to vote, then increments candidates stats once they vote
    function voterForCandidate(bytes32 Candid, address personToVote) public {
        require(voter[!personToVote].HasVoted, "You have already cast your vote");
        require(voter[personToVote].howManyVotesCanCast != 0, "You aren't eligible to vote");
        require(ValidCandidacy(Candid));
        CandidateScore[Candid] +=1;
    }

    // View votes of candidate

    function VotesOfCandidate(bytes32 Candid) public view returns(uint256) {
        require(ValidCandidacy(Candid));
        return CandidateScore[Candid];

    }

    



}