//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
//transfer 2300gas reverts
//send 2300 gas returns bool
//call all gas,returns bool and data

contract Wallet {
  address payable public owner;
  constructor() payable {
    owner = payable(msg.sender);
  }
  receive() external  payable{}
  
  function withdraw(uint _amount) external {
    require(msg.sender == owner,"not owner");
    payable(msg.sender).transfer(_amount);
  }
  function getbalance() external view returns (uint){
    return address(this).balance; 
  }
}
