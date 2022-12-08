//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
//virturl 可覆盖合约
contract A {
  function foo() public pure virtual returns (string memory) {
      return "A";
  }
  function bar() public pure virtual  returns (string memory) {
      return "AA";
  }
  function baz() public pure returns (string memory) {
      return "AAA";
  }

}
contract B is A {
  function foo() public pure override  returns (string memory) {
      return "B";
  }
  function bar() public pure override virtual returns (string memory) {
      return "BB";
  }


}
contract C is B {
  function bar() public pure override virtual returns (string memory) {
      return "CC";
  }


}
