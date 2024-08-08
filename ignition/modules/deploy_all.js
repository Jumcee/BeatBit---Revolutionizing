const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  // Deploy MusicMarketplace
  const MusicMarketplace = await ethers.getContractFactory("MusicMarketplace");
  const musicMarketplace = await MusicMarketplace.deploy();
  console.log("MusicMarketplace deployed to:", musicMarketplace.target);

  // Deploy ShortReels
  const ShortReels = await ethers.getContractFactory("ShortReels");
  const shortReels = await ShortReels.deploy();
  console.log("ShortReels deployed to:", shortReels.target);

  // // Deploy BeatBitNFT
  // const BeatBitNFT = await ethers.getContractFactory("BeatBitNFT");
  // const beatBitNFT = await BeatBitNFT.deploy("BeatBit NFT", "BBNFT"); // Provide required arguments
  // console.log("BeatBitNFT deployed to:", beatBitNFT.target);

  // // Deploy BeatBitRewards
  // const BeatBitRewards = await ethers.getContractFactory("BeatBitRewards");
  // const beatBitRewards = await BeatBitRewards.deploy(); // Assuming no arguments
  // console.log("BeatBitRewards deployed to:", beatBitRewards.target);

  // // Deploy BeatBitStaking
  // const BeatBitStaking = await ethers.getContractFactory("BeatBitStaking");
  // const beatBitStaking = await BeatBitStaking.deploy(); // Assuming no arguments
  // console.log("BeatBitStaking deployed to:", (await beatBitStaking.deployed()).address);

  // // Deploy EnhancedStaking
  // const EnhancedStaking = await ethers.getContractFactory("EnhancedStaking");
  // const enhancedStaking = await EnhancedStaking.deploy(); // Assuming no arguments
  // console.log("EnhancedStaking deployed to:", (await enhancedStaking.deployed()).address);

  // // Deploy MusicTokenBridge
  // const MusicTokenBridge = await ethers.getContractFactory("MusicTokenBridge");
  // const musicTokenBridge = await MusicTokenBridge.deploy(); // Assuming no arguments
  // console.log("MusicTokenBridge deployed to:", (await musicTokenBridge.deployed()).address);

  // // Deploy RadioStreaming
  // const RadioStreaming = await ethers.getContractFactory("RadioStreaming");
  // const radioStreaming = await RadioStreaming.deploy(); // Assuming no arguments
  // console.log("RadioStreaming deployed to:", radioStreaming.target);

  // // Deploy MusicFutureTrading
  // const MusicFutureTrading = await ethers.getContractFactory("MusicFutureTrading");
  // const musicFutureTrading = await MusicFutureTrading.deploy(); // Assuming no arguments
  // console.log("MusicFutureTrading deployed to:", musicFutureTrading.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Error deploying contracts:", error);
    process.exit(1);
  });
