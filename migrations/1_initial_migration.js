const Migrations = artifacts.require("Migrations");

//the functions exported by each migration takes in a deployer object as an argument
module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
