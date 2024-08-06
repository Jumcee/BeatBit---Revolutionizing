// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BeatBitDAO is Ownable {
    // Struct to define a proposal
    struct Proposal {
        uint256 id;
        string description;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 deadline;
        bool executed;
    }

    // State variables
    IERC20 public governanceToken;
    uint256 public proposalCount;
    mapping(uint256 => Proposal) public proposals;

    // Constructor to initialize the governance token
    constructor(address _governanceToken) {
        governanceToken = IERC20(_governanceToken);
    }

    // Function to create a new proposal
    function createProposal(string memory description) external onlyOwner {
        proposalCount++;
        proposals[proposalCount] = Proposal(
            proposalCount,
            description,
            0,
            0,
            block.timestamp + 1 weeks,
            false
        );
    }

    // Function to vote on a proposal
    function vote(uint256 proposalId, bool support) external {
        Proposal storage proposal = proposals[proposalId];
        require(block.timestamp < proposal.deadline, "Voting period ended");
        require(!proposal.executed, "Proposal already executed");

        uint256 voterBalance = governanceToken.balanceOf(msg.sender);
        require(voterBalance > 0, "No tokens to vote with");

        if (support) {
            proposal.votesFor += voterBalance;
        } else {
            proposal.votesAgainst += voterBalance;
        }
    }

    // Function to execute a proposal
    function executeProposal(uint256 proposalId) external onlyOwner {
        Proposal storage proposal = proposals[proposalId];
        require(block.timestamp >= proposal.deadline, "Voting period not ended");
        require(!proposal.executed, "Proposal already executed");

        if (proposal.votesFor > proposal.votesAgainst) {
            // Logic to execute proposal goes here
            // For example, interacting with other contracts or transferring funds
        }

        proposal.executed = true;
    }
}
