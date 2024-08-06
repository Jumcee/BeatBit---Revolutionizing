// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";

contract BeatBitStaking is Ownable {
    IERC20 public stakingToken;
    uint256 public rewardRate = 100; // Example reward rate

    struct Staker {
        uint256 balance;
        uint256 reward;
    }

    mapping(address => Staker) public stakers;

    constructor(IERC20 _stakingToken) {
        stakingToken = _stakingToken;
    }

    function stake(uint256 amount) external {
        require(amount > 0, "Cannot stake 0");
        stakingToken.transferFrom(msg.sender, address(this), amount);
        stakers[msg.sender].balance += amount;
        // Calculate and distribute rewards
    }

    function withdraw(uint256 amount) external {
        require(stakers[msg.sender].balance >= amount, "Insufficient balance");
        stakingToken.transfer(msg.sender, amount);
        stakers[msg.sender].balance -= amount;
        // Update rewards
    }

    function claimReward() external {
        uint256 reward = stakers[msg.sender].reward;
        require(reward > 0, "No rewards to claim");
        // Transfer reward to the staker
    }
}