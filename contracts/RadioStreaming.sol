// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";

contract RadioStreaming is Ownable {
    struct Station {
        uint256 stakedTokens;
        uint256 lastUpdated;
    }

    mapping(address => Station) public stations;
    mapping(address => uint256) public rewards;

    address public tokenAddress;
    uint256 public rewardRate; // Reward rate per staked token per second

    event TokensStaked(address indexed user, uint256 amount);
    event RewardClaimed(address indexed user, uint256 reward);

    constructor(address _tokenAddress, uint256 _rewardRate) {
        tokenAddress = _tokenAddress;
        rewardRate = _rewardRate;
    }

    function stakeTokens(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");

        IERC20(tokenAddress).transferFrom(msg.sender, address(this), amount);

        Station storage station = stations[msg.sender];
        _updateReward(station);

        station.stakedTokens += amount;
        station.lastUpdated = block.timestamp;

        emit TokensStaked(msg.sender, amount);
    }

    function claimReward() external {
        Station storage station = stations[msg.sender];
        _updateReward(station);

        uint256 reward = rewards[msg.sender];
        require(reward > 0, "No rewards available");

        rewards[msg.sender] = 0;
        IERC20(tokenAddress).transfer(msg.sender, reward);

        emit RewardClaimed(msg.sender, reward);
    }

    function _updateReward(Station storage station) internal {
        if (station.stakedTokens > 0) {
            uint256 timeElapsed = block.timestamp - station.lastUpdated;
            uint256 reward = station.stakedTokens * rewardRate * timeElapsed / 1e18;
            rewards[msg.sender] += reward;
        }
        station.lastUpdated = block.timestamp;
    }

    function setTokenAddress(address _tokenAddress) external onlyOwner {
        tokenAddress = _tokenAddress;
    }

    function setRewardRate(uint256 _rewardRate) external onlyOwner {
        rewardRate = _rewardRate;
    }
}
