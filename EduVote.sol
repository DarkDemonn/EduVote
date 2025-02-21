// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EduVote {
    mapping(address => uint256) public engagementPoints;
    mapping(address => uint256) public votingPower;
    mapping(address => bool) public hasVoted;
    uint256 public totalVotes;

    event EngagementRecorded(address user, uint256 points);
    event VoteCasted(address user, uint256 power);

    function recordEngagement() public {
        engagementPoints[msg.sender] += 1;
        votingPower[msg.sender] = engagementPoints[msg.sender] * engagementPoints[msg.sender];
        emit EngagementRecorded(msg.sender, engagementPoints[msg.sender]);
    }

    function castVote() public {
        require(!hasVoted[msg.sender], "Already voted");
        require(votingPower[msg.sender] > 0, "No voting power");
        hasVoted[msg.sender] = true;
        totalVotes += votingPower[msg.sender];
        emit VoteCasted(msg.sender, votingPower[msg.sender]);
    }

    function getEngagementPoints() public view returns (uint256) {
        return engagementPoints[msg.sender];
    }

    function getVotingPower() public view returns (uint256) {
        return votingPower[msg.sender];
    }
}
