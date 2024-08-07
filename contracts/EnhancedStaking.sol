// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EnhancedStaking is Ownable {
    IERC20 public stakingToken;
    mapping(address => uint256) public stakedBalances;
    mapping(address => uint256) public rewardBalances;
    address[] public stakers;
    uint256 public totalStaked;
    uint256 public rewardRate;

    constructor(address _stakingToken, uint256 _rewardRate, address initialOwner) Ownable(initialOwner) {
        stakingToken = IERC20(_stakingToken);
        rewardRate = _rewardRate;
    }

    function stake(uint256 amount) external {
        require(amount > 0, "Cannot stake 0 tokens");

        if (stakedBalances[msg.sender] == 0) {
            stakers.push(msg.sender);  // Add to stakers array
        }

        stakedBalances[msg.sender] += amount;
        totalStaked += amount;

        stakingToken.transferFrom(msg.sender, address(this), amount);
    }

    function unstake(uint256 amount) external {
        require(stakedBalances[msg.sender] >= amount, "Insufficient balance to unstake");

        stakedBalances[msg.sender] -= amount;
        totalStaked -= amount;

        if (stakedBalances[msg.sender] == 0) {
            // Remove from stakers array
            for (uint256 i = 0; i < stakers.length; i++) {
                if (stakers[i] == msg.sender) {
                    stakers[i] = stakers[stakers.length - 1];
                    stakers.pop();
                    break;
                }
            }
        }

        stakingToken.transfer(msg.sender, amount);
    }

    function distributeRewards() external onlyOwner {
        for (uint256 i = 0; i < stakers.length; i++) {
            address staker = stakers[i];
            uint256 reward = calculateReward(staker);
            rewardBalances[staker] += reward;
        }
    }

    function claimRewards() external {
        uint256 reward = rewardBalances[msg.sender];
        require(reward > 0, "No rewards to claim");

        rewardBalances[msg.sender] = 0;
        stakingToken.transfer(msg.sender, reward);
    }

    function calculateReward(address account) public view returns (uint256) {
        return stakedBalances[account] * rewardRate;
    }

    function getStakedBalance(address account) external view returns (uint256) {
        return stakedBalances[account];
    }

    function getStakers() external view returns (address[] memory) {
        return stakers;
    }
}
