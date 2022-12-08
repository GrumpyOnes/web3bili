//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Counter{
  uint public counter;
  function count() external view returns(uint){
    return counter;
  }
  function inc() external {
    counter++;
  }

}

interface  ICounter {
  function count() external view returns(uint);
  function inc() external;
}

contract CallInterface {
  uint public count;
  function examples(address _counter) external {
    ICounter(_counter).inc();
    count = ICounter(_counter).count();
  }
}