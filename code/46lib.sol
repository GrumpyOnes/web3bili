//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

library Math {
  function max(uint _x,uint _y) pure internal returns (uint) {
    return _x>_y?_x:_y;
  }
}
contract Test {
  function test(uint _x,uint _y) pure external returns (uint) {
    uint x = Math.max(_x,_y);
    return x;
  }
}

library ArrayLib {
  function find(uint[] storage arr,uint x) internal view returns (uint){
    for(uint i=0;i<arr.length;i++){
      if(arr[i]==x){
        return i;
      }
    }
    revert("not found");
  }
}
contract TestArray {
  uint[] public arr =[3,2,1];
  function  testFind() external  view returns (uint i) {
    return ArrayLib.find(arr,2);
  } 
}