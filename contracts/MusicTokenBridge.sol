// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MusicTokenBridge is Ownable {
    IERC20 public token;

    constructor(address _token, address initialOwner) Ownable(initialOwner) {
        token = IERC20(_token);
    }

    function deposit(uint256 amount) external {
        require(amount > 0, "Cannot deposit 0 tokens");

        token.transferFrom(msg.sender, address(this), amount);
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
