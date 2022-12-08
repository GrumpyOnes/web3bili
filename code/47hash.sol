//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract HashFunc {
  //计算hash值
  function hash(string memory text,uint num,address addr) external pure returns(bytes32) {
    return keccak256(abi.encodePacked(text,num,addr));
  }
  //encode 和 encodePacked
  function encode(string memory txt1,string memory txt2) external  pure  returns(bytes memory) {
    return abi.encode(txt1,txt2);
  }
  //容易出现碰撞错误  “AAB”，“B”   == “AA”，“BB”
  function encodePacked(string memory txt1,string memory txt2) external  pure  returns(bytes memory) {
    return abi.encodePacked(txt1,txt2);
  }
  //解决碰撞
  function encodePackedwith(string memory txt1,uint num,string memory txt2) external  pure  returns(bytes memory) {
    return abi.encodePacked(txt1,num,txt2);
  }
}
