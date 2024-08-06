// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BeatBitStaking is Ownable {
    IERC20 public stakingToken;

    mapping(address => uint256) public stakedBalances;
    uint256 public totalStaked;

    constructor(address _stakingToken) Ownable(msg.sender) {
        stakingToken = IERC20(_stakingToken);
    }

    function stake(uint256 amount) external {
        require(amount > 0, "Cannot stake 0 tokens");

        stakedBalances[msg.sender] += amount;
        totalStaked += amount;

        stakingToken.transferFrom(msg.sender, address(this), amount);
    }

    function unstake(uint256 amount) external {
        require(stakedBalances[msg.sender] >= amount, "Insufficient balance to unstake");

        stakedBalances[msg.sender] -= amount;
        totalStaked -= amount;

        stakingToken.transfer(msg.sender, amount);
    }

    function getStakedBalance(address account) external view returns (uint256) {
        return stakedBalances[account];
    }
}
