const hre = require("hardhat");

async function main() {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    // Deploy MusicTokenBridge
    const TokenAddress = "0xYourTokenAddressHere"; // Replace with actual token address
    const InitialOwner = deployer.address; // Or specify another address
    const MusicTokenBridge = await hre.ethers.getContractFactory("MusicTokenBridge");
    const musicTokenBridge = await MusicTokenBridge.deploy(TokenAddress, InitialOwner);
    console.log("MusicTokenBridge deployed to:", musicTokenBridge.address);

    // Deploy RadioStreaming
    const RadioStreaming = await hre.ethers.getContractFactory("RadioStreaming");
    const radioStreaming = await RadioStreaming.deploy(TokenAddress, InitialOwner);
    console.log("RadioStreaming deployed to:", radioStreaming.address);

    // Deploy EnhancedStaking
    const StakingTokenAddress = "0xYourStakingTokenAddressHere"; // Replace with actual staking token address
    const RewardRate = 1000; // Replace with actual reward rate
    const EnhancedStaking = await hre.ethers.getContractFactory("EnhancedStaking");
    const enhancedStaking = await EnhancedStaking.deploy(StakingTokenAddress, RewardRate, InitialOwner);
    console.log("EnhancedStaking deployed to:", enhancedStaking.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
