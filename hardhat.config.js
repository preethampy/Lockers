/** @type import('hardhat/config').HardhatUserConfig */
require('@nomiclabs/hardhat-ethers');
require("@nomiclabs/hardhat-etherscan");
require('dotenv').config()
module.exports = {
  solidity: "0.8.0",
  networks:{
    goerli:{
      url:process.env.ALCHEMY_GOERLI,
      accounts:[process.env.METAMASK_PRIVATE_KEY]
    }
  },
  etherscan:{
    apiKey:process.env.ETHERSCAN_APIKEY
  },
};
