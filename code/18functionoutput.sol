//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Output {
  function returnMany() public pure returns (uint, bool){
      return (1,false);
  }
  function named() public pure returns (uint x,bool y){
      return (2,true);
  }
  function assigned() public pure returns(uint x,bool y){
      x = 3;
      y = true;
  }
  function destructingAssigments() public pure {
      (uint x,bool y) =returnMany();
      x;
      y;
  }
}