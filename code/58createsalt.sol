// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract DeploywithCreate2 {
  address public owner;
  constructor(address _owner){
    owner = _owner;
  }
}
contract Create2Factory {
  event Deploy(address addr);
  function deploy(uint _salt) external {
    DeploywithCreate2 _contract = new DeploywithCreate2{
      salt: bytes32(_salt) //加盐 不通
    }(msg.sender);
    emit Deploy(address(_contract));//新生成的合约地址
  }
  //计算地址方法
  function getAddress(bytes memory bytecode,uint _salt)
  public view returns (address){
    bytes32 hash = keccak256(
      abi.encodePacked(bytes1(0xff),address(this),_salt,keccak256(bytecode)));
    return address(uint160(uint(hash)));//地址为uint160格式
  }
  //获取 bytecode
  function getBytecode(address _owner) public pure returns(bytes memory) {
    bytes memory bytecode = type(DeploywithCreate2).creationCode;//生成机器码
    return abi.encodePacked(bytecode,abi.encode(_owner));
  }
}