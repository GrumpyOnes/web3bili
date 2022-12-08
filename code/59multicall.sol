//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract TestMultiCall {
  function func1() external view returns (uint,uint) {
    return (1,block.timestamp);
  }
  function func2() external view returns (uint,uint) {
    return (2,block.timestamp);
  }
  //获取func1的encode码
  function getData1() external  pure returns (bytes memory){
    return abi.encodeWithSelector(this.func1.selector);
  }
  //获取func2的encode码
  function getData2() external  pure returns (bytes memory){
    return abi.encodeWithSelector(this.func2.selector);
  }
}

contract MultiCall{
  function multiCall(address[] calldata targets,bytes[] calldata data)
  external view returns (bytes[] memory){
    require(targets.length ==data.length,"target length != data length");
    bytes[] memory results = new bytes[](data.length);
    for(uint i;i<targets.length;i++){
      (bool success,bytes memory result)=targets[i].staticcall(data[i]);
      require(success,"call failed");
      results[i] = result;
    }
    return results;
  }
}


