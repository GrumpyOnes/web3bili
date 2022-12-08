//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Array {
  uint[] public nums = [1,2,3]; //
  uint[3] public numsFixed=[4,5,6]; //定长数组
  function examples() external {
      nums.push(4);//[1,2,3,4]
      uint x = nums[1];
      nums[2] = 77; //[1,2,777,4]
      delete nums[1];//[1,0,777,4]
      nums.pop();//[1,0,777]
      uint len = nums.length;
      //create array in memory
      uint[] memory a = new uint[](5);//内存中不能定义不定长数组 不能使用pop 
      a[2] = 888;
  }
function returnArray() external view returns (uint[] memory) {
    return nums;
}
}