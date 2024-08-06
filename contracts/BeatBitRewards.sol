// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";

contract BeatBitRewards is Ownable {
    IERC20 public rewardToken;

    struct Reward {
        uint256 amount;
        bool claimed;
    }

    mapping(address => Reward) public rewards;

    constructor(IERC20 _rewardToken) {
        rewardToken = _rewardToken;
    }

    function setReward(address recipient, uint256 amount) external onlyOwner {
        rewards[recipient] = Reward(amount, false);
    }

    function claimReward() external {
        Reward storage reward = rewards[msg.sender];
        require(reward.amount > 0, "No rewards to claim");
        require(!reward.claimed, "Reward already claimed");

        rewardToken.transfer(msg.sender, reward.amount);
        reward.claimed = true;
    }
}
