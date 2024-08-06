// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BeatBitLiquidityPool is Ownable {
    IERC20 public stakingToken;
    uint256 public totalStaked;

    struct Stake {
        uint256 amount;
        uint256 timestamp;
    }

    mapping(address => Stake) public stakes;

    constructor(IERC20 _stakingToken) {
        stakingToken = _stakingToken;
    }

    function stakeTokens(uint256 amount) external {
        require(amount > 0, "Cannot stake 0");
        stakingToken.transferFrom(msg.sender, address(this), amount);
        totalStaked += amount;
        stakes[msg.sender] = Stake(amount, block.timestamp);
    }

    function withdrawTokens() external {
        Stake memory userStake = stakes[msg.sender];
        require(userStake.amount > 0, "No tokens to withdraw");
        // Calculate share of revenue based on staking duration
        stakingToken.transfer(msg.sender, userStake.amount);
        totalStaked -= userStake.amount;
        delete stakes[msg.sender];
    }
}
