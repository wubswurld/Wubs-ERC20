const Wubs = artifacts.require("Wubs");

//the functions exported by each migration takes in a deployer object as an argument
module.exports = function(deployer) {
  deployer.deploy(Wubs);
};
