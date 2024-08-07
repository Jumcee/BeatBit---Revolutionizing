// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BeatBitDAO is Ownable {
    IERC20 public governanceToken;

    uint256 public proposalCount;
    
    struct Proposal {
        uint256 id;
        string description;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 deadline;
        bool executed;
    }

    mapping(uint256 => Proposal) public proposals;

    constructor(address _governanceToken, address initialOwner) Ownable(initialOwner) {
        governanceToken = IERC20(_governanceToken);
    }

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

    function vote(uint256 proposalId, bool support) external {
        Proposal storage proposal = proposals[proposalId];
        require(block.timestamp < proposal.deadline, "Voting period ended");
        require(!proposal.executed, "Proposal already executed");

        if (support) {
            proposal.votesFor += governanceToken.balanceOf(msg.sender);
        } else {
            proposal.votesAgainst += governanceToken.balanceOf(msg.sender);
        }
    }

    function executeProposal(uint256 proposalId) external onlyOwner {
        Proposal storage proposal = proposals[proposalId];
        require(block.timestamp >= proposal.deadline, "Voting period not ended");
        require(!proposal.executed, "Proposal already executed");

        if (proposal.votesFor > proposal.votesAgainst) {
            // Execute proposal
        }

        proposal.executed = true;
    }
}
