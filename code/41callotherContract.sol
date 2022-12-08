//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
//transfer 2300gas reverts
//send 2300 gas returns bool
//call all gas,returns bool and data

contract CallTestContract {
  function setX(address _test,uint _x) external {
    TestContract(_test).setX(_x);
  }
  function getX(TestContract _test) external view returns (uint x){
    x = _test.getX();
  }
  function setxandReceiveEther(address _test,uint _x) payable external {
    TestContract(_test).setXandReceiveEther{value:msg.value}(_x);
  }
  function getXandValue(TestContract _test) external view returns (uint x,uint value){
    (x,value) = _test.getXandValue();
  }
}

contract TestContract {
  uint public x;
  uint public value = 123;
  function setX(uint _x) external {
    x = _x;
  }
  function getX() external view returns (uint myx){
    myx = x;
  }
  function setXandReceiveEther(uint _x) external payable{
    x = _x;
    value = msg.value;
  }
  function getXandValue() external view returns (uint,uint){
    return (x,value);
  }
}
