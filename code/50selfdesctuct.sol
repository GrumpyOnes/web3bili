//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Kill {
  constructor() payable{}
  function kill() external {
    selfdestruct(payable(msg.sender));
  }
  function test() external pure returns (uint) {
    return 123;
  }
}
contract ToKill {
  function kill(Kill _kill) external {
    _kill.kill();
  }
  function getBalance() external view returns(uint){
    return address(this).balance;
  }
}

//通过toKill 执行 Kill中的kill方法，Kill中的主币全都转给toKill （虽然ToKill没有payable属性）