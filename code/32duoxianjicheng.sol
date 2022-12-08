//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
//virturl 可覆盖合约
contract X {
  function foo() public pure virtual returns (string memory) {
      return "X";
  }
  function bar() public pure virtual  returns (string memory) {
      return "XX";
  }
  function baz() public pure returns (string memory) {
      return "XXX";
  }

}
contract Y is X {
  function foo() public pure override virtual returns (string memory) {
      return "Y";
  }
  function bar() public pure override virtual returns (string memory) {
      return "YY";
  }


}
//继承需要注意深浅顺序 深在前
contract Z is X,Y {
  function bar() public pure override(Y,X) returns (string memory) {
      return "ZZ";
  }
  function foo() public pure override(X,Y) returns (string memory) {
      return "Z";
  }


}
