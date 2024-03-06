require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  networks: {
    hardhat: {
      chainId: 1337,
    },
  },
  paths: {
    artifacts: "./client/src/artifacts",//determine the folder where byte code and ABI gets stored when we compile/deploy
  },
};