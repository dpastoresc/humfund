const Winner = artifacts.require("./Winner.sol")
const Core = artifacts.require("./Core.sol")

module.exports = function(deployer) {
    deployer.deploy(Winner)
    deployer.deploy(Core)
}