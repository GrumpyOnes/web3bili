//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
//transfer 2300gas reverts
//send 2300 gas returns bool
//call all gas,returns bool and data

contract SendEther {
  receive() external payable{}
  constructor() payable {}
  function sendtransfer(address payable _to) external  payable {
    _to.transfer(123);
  }
  function sendsend(address payable _to) external  payable {
    bool sent = _to.send(123);
    require(sent,"failed");
  }
  function sendcall(address payable _to) external  payable {
    (bool success,) = _to.call{value:112}("");
    require(success,"call failed");
  }
}
contract EtheReceiver {
  event Log(uint amount,uint gas);
  receive() external payable{
    emit Log(msg.value,gasleft());
  }
}
