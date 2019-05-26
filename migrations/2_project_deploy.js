const Winner = artifacts.require("./Winner.sol")
const Core = artifacts.require("./Core.sol")
const Voter = artifacts.require("./Voter.sol")

module.exports = function(deployer) {
    deployer.deploy(Winner)
    deployer.deploy(Core)
    deployer.deploy(Voter)
}