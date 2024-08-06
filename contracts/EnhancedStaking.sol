// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";

contract EnhancedStaking is Ownable {
    struct Staker {
        uint256 amountStaked;
        uint256 rewardDebt;
        uint256 lastClaimed;
    }

    mapping(address => Staker) public stakers;
    address public tokenAddress;
    uint256 public rewardRate;
    uint256 public totalStaked;
    uint256 public accRewardPerShare;

    constructor(address _tokenAddress, uint256 _rewardRate) {
        tokenAddress = _tokenAddress;
        rewardRate = _rewardRate;
    }

    function stake(uint256 amount) external {
        IERC20(tokenAddress).transferFrom(msg.sender, address(this), amount);

        Staker storage staker = stakers[msg.sender];
        _updateRewards(staker);

        staker.amountStaked += amount;
        staker.rewardDebt = staker.amountStaked * accRewardPerShare / 1e12;
        totalStaked += amount;
    }

    function claimRewards() external {
        Staker storage staker = stakers[msg.sender];
        _updateRewards(staker);

        uint256 reward = staker.amountStaked * accRewardPerShare / 1e12 - staker.rewardDebt;
        require(reward > 0, "No rewards available");

        IERC20(tokenAddress).transfer(msg.sender, reward);
        staker.rewardDebt = staker.amountStaked * accRewardPerShare / 1e12;
    }

    function _updateRewards(Staker storage staker) internal {
        if (totalStaked > 0) {
            uint256 reward = (block.timestamp - staker.lastClaimed) * rewardRate * staker.amountStaked / totalStaked;
            accRewardPerShare += reward * 1e12 / totalStaked;
            staker.lastClaimed = block.timestamp;
        }
    }

    function unstake(uint256 amount) external {
        Staker storage staker = stakers[msg.sender];
        require(staker.amountStaked >= amount, "Insufficient staked amount");

        _updateRewards(staker);

        staker.amountStaked -= amount;
        staker.rewardDebt = staker.amountStaked * accRewardPerShare / 1e12;
        totalStaked -= amount;

        IERC20(tokenAddress).transfer(msg.sender, amount);
    }

    function setRewardRate(uint256 _rewardRate) external onlyOwner {
        rewardRate = _rewardRate;
    }
}
