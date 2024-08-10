const { expect } = require("chai");

// describe("ShortReels", function () {
//     let shortReels;

    contract("ShortReels", accounts => {
        let shortReels;
        let account1, account2;
      
        beforeEach(async () => {
          shortReels = await ShortReels.deployed();
          account1 = accounts[0];
          account2 = accounts[1];
        });
      
        it("should create a reel", async () => {
          const contentUrl = "https://example.com/reel1";
          await shortReels.createReel(contentUrl, { from: account1 });
      
          const reel = await shortReels.reels(0);
          assert.equal(reel.creator, account1);
          assert.equal(reel.contentUrl, contentUrl);
          assert.equal(reel.engagementScore, 0);
          assert.equal(reel.rewardPool, 0);
        });
      
        it("should engage with a reel", async () => {
          await shortReels.createReel("https://example.com/reel1", { from: account1 });
      
          const engagementPoints = 100;
          await shortReels.engageWithReel(0, engagementPoints, { from: account2 });
      
          const reel = await shortReels.reels(0);
          assert.equal(reel.engagementScore, engagementPoints);
          assert.equal(reel.rewardPool, engagementPoints);
        });
      
        it("should distribute reel rewards", async () => {
          await shortReels.createReel("https://example.com/reel1", { from: account1 });
          await shortReels.engageWithReel(0, 100, { from: account2 });
      
          const initialBalance = await web3.eth.getBalance(account1);
      
          await shortReels.distributeReelRewards(0, { from: account1 });
      
          const finalBalance = await web3.eth.getBalance(account1);
          const reward = finalBalance.sub(initialBalance);
      
          const reel = await shortReels.reels(0);
          assert.equal(reel.rewardPool, 0);
          // Assert that the creator received the correct reward (creatorReward)
        });
      
        // Add more tests for different scenarios (e.g., insufficient engagement points, invalid reel ID, etc.)
      });
