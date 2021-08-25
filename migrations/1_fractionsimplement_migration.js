const FractionsImplement = artifacts.require("FractionsImplement");

module.exports = async function (deployer, network, accounts) {
    // deployment steps
    await deployer.deploy(FractionsImplement);
};