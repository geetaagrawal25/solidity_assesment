const { expect } = require("chai")
const { ethers } = require('hardhat');

describe("claimingContract", () => {
  

  it("sets the claiming period", async () => {
  const [deployer] = await ethers.getSigners()
  
    // Deploy contract
   const claimContract = await ethers.getContractFactory("claimContract")
   const claim = await claimContract.deploy()


   //Function call setPeriod() to set the strating period
   const txn = await claim.connect(deployer).setPeriod()
   await txn.wait()

    // Retrieve the block number from the transaction receipt
    const blockNumber = await ethers.provider.getBlockNumber();
    console.log(blockNumber);

    const block = await ethers.provider.getBlock(blockNumber);
   
    // Assert that the startRequest timestamp matches the block timestamp
    expect(await claim.startRequest()).to.equal(block.timestamp);
  })


  });