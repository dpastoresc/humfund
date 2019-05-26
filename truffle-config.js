const HDWalletProvider = require("truffle-hdwallet-provider");

require('dotenv').config()  // Store environment-specific variable from '.env' to process.env

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // for more about customizing your Truffle configuration!
  networks: {
    development: {
      host: "rinkeby.infura.io/v3/371b884c687647b9be1395dc80f7952b",
      port: 7545,
      network_id: "*" // Match any network id
    },
    rinkeby: {
      provider: () => new HDWalletProvider(process.env.PRIVATE_KEY, "https://rinkeby.infura.io/v3/371b884c687647b9be1395dc80f7952b"),
      network_id: 4,
      gas: 3000000,
      gasPrice: 10000000000
    },
    ropsten: {
      provider: () => new HDWalletProvider(process.env.PRIVATE_KEY, "https://ropsten.infura.io/v3/371b884c687647b9be1395dc80f7952b"),
      network_id: 3,
      gas: 3000000,
      gasPrice: 10000000000
    }
  }
};
