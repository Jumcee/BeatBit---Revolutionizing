// scripts/deploy_all.js
const { ethers } = require("hardhat");

async function main() {
  // Deploy BeatBitNFT
  console.log("Deploying BeatBitNFT...");
  const BeatBitNFT = await ethers.getContractFactory("BeatBitNFT");
  const beatBitNFT = await BeatBitNFT.deploy("BeatBit NFT", "BBNFT"); // Provide required arguments
  await beatBitNFT.deployed();
  console.log("BeatBitNFT deployed to:", beatBitNFT.address);

  // Deploy BeatBitRewards
  console.log("Deploying BeatBitRewards...");
  const BeatBitRewards = await ethers.getContractFactory("BeatBitRewards");
  const beatBitRewards = await BeatBitRewards.deploy(); // Assuming no arguments
  await beatBitRewards.deployed();
  console.log("BeatBitRewards deployed to:", beatBitRewards.address);

  // Deploy BeatBitStaking
  console.log("Deploying BeatBitStaking...");
  const BeatBitStaking = await ethers.getContractFactory("BeatBitStaking");
  const beatBitStaking = await BeatBitStaking.deploy(); // Assuming no arguments
  await beatBitStaking.deployed();
  console.log("BeatBitStaking deployed to:", beatBitStaking.address);

  // Deploy EnhancedStaking
  console.log("Deploying EnhancedStaking...");
  const EnhancedStaking = await ethers.getContractFactory("EnhancedStaking");
  const enhancedStaking = await EnhancedStaking.deploy(); // Assuming no arguments
  await enhancedStaking.deployed();
  console.log("EnhancedStaking deployed to:", enhancedStaking.address);

  // Deploy MusicTokenBridge
  console.log("Deploying MusicTokenBridge...");
  const MusicTokenBridge = await ethers.getContractFactory("MusicTokenBridge");
  const musicTokenBridge = await MusicTokenBridge.deploy(); // Assuming no arguments
  await musicTokenBridge.deployed();
  console.log("MusicTokenBridge deployed to:", musicTokenBridge.address);

  // Deploy RadioStreaming
  console.log("Deploying RadioStreaming...");
  const RadioStreaming = await ethers.getContractFactory("RadioStreaming");
  const radioStreaming = await RadioStreaming.deploy(); // Assuming no arguments
  await radioStreaming.deployed();
  console.log("RadioStreaming deployed to:", radioStreaming.address);

  // Deploy MusicFutureTrading
  console.log("Deploying MusicFutureTrading...");
  const MusicFutureTrading = await ethers.getContractFactory("MusicFutureTrading");
  const musicFutureTrading = await MusicFutureTrading.deploy(); // Assuming no arguments
  await musicFutureTrading.deployed();
  console.log("MusicFutureTrading deployed to:", musicFutureTrading.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Error deploying contracts:", error);
    process.exit(1);
  });
