// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.16;

contract claimContract {

address public admin;
uint256 expiryDate;
uint256 public startRequest;
address[] public requestedList;


  mapping(address => bool) alreadyRequested;


    constructor(){
        admin = msg.sender;
    }

    modifier onlyAdmin{
    require(msg.sender == admin, "Only Admin has access");
    _;
    }

    //

    function setPeriod() external onlyAdmin{
        require(startRequest == 0, "Claiming Already started");
        startRequest = block.timestamp;
        expiryDate = startRequest + (14 days);
    }

     function isExpired() private view returns (bool) {
        return (block.timestamp >= expiryDate);
    }

    function requestRefund() public {
        require(alreadyRequested[msg.sender] == false, "Already requested"); // check if the user already requested
        require(!isExpired(), "Refund Request Expired"); //Checking the expiry period
        require(block.timestamp >= startRequest + 24 hours, "Requesting Refund will start soon..."); //check if 24hours passed

        requestedList.push(msg.sender);
        alreadyRequested[msg.sender] = true;

    }

    //collect wallets that request a refund
    function getRequestedList() public view onlyAdmin returns(address[] memory)  {
        return requestedList;
        }
    
// Admin removes the wallets
    function RemoveRequestedList() public onlyAdmin {
        delete requestedList;
    }


}


