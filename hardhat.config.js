require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const { RPC_URL, PRIVATE_KEY } = process.env;

module.exports = {
  networks: {
    bscTestnet: {
      url: process.env.RPC_URL,
      accounts: [process.env.PRIVATE_KEY], 
    },
  },
  solidity: "0.8.20",
};
