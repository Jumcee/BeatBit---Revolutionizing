// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RadioStreaming is Ownable {
    IERC20 public token;

    constructor(address _token, address initialOwner) Ownable(initialOwner) {
        token = IERC20(_token);
    }

    struct Station {
        string name;
        uint256 stakedTokens;
    }

    mapping(address => uint256) public rewards;
    mapping(uint256 => Station) public stations;
    uint256 public stationCount;

    function createStation(string memory name) external onlyOwner {
        stationCount++;
        stations[stationCount] = Station(name, 0);
    }

    function stake(uint256 stationId, uint256 amount) external {
        require(amount > 0, "Cannot stake 0 tokens");

        token.transferFrom(msg.sender, address(this), amount);

        stations[stationId].stakedTokens += amount;
        rewards[msg.sender] += amount; // Assuming rewards are added based on staked tokens
    }

    function withdraw(uint256 amount) external onlyOwner {
        require(amount > 0, "Cannot withdraw 0 tokens");
        require(token.balanceOf(address(this)) >= amount, "Insufficient balance");

        token.transfer(msg.sender, amount);
    }

    function reward(address to, uint256 amount) external onlyOwner {
        require(amount > 0, "Cannot reward 0 tokens");
        require(token.balanceOf(address(this)) >= amount, "Insufficient balance");

        token.transfer(to, amount);
    }
}
