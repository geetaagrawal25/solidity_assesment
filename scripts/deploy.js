const ethers = require('ethers');

async function main() {
  // Setup accounts & variables
  const [admin] = await ethers.getSigners()

   // Deploy contract
   const claimContract = await ethers.getContractFactory("claimContract")
   const claim = await claimContract.deploy()
   await claim.deployed()

   console.log(`Deployed TokenMaster Contract at: ${claim.address}\n`)

}