// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ShortReels {
    struct Reel {
        address creator;
        string contentUrl;
        uint256 engagementScore;
        uint256 rewardPool;
    }

    mapping(uint256 => Reel) public reels;
    uint256 public reelCount;

    function createReel(string memory contentUrl) public {
        reels[reelCount] = Reel(msg.sender, contentUrl, 0, 0);
        reelCount++;
    }

    function engageWithReel(uint256 reelId, uint256 engagementPoints) public {
        Reel storage reel = reels[reelId];
        reel.engagementScore += engagementPoints;

        // Add engagement points to the reward pool
        reel.rewardPool += engagementPoints;
    }

    function distributeReelRewards(uint256 reelId) public {
        Reel storage reel = reels[reelId];
        uint256 reward = reel.rewardPool;

        // Distribute rewards based on engagement score
        uint256 creatorReward = (reel.engagementScore / 100) * reward;
        payable(reel.creator).transfer(creatorReward);

        reel.rewardPool = 0;
    }
}
