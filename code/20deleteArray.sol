//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract DelArray {
   uint[] public arr;
   function example() public {
       arr=[1,2,3];
       delete arr[1];//1, 0,3
   }
   //方法1 [1,2,3,4] [1,0,3,4] [1,3,4,4] [1,3,4]
   function remove(uint _index) public {
       require(_index <arr.length,"out of bound");
       for(uint i = _index;i<arr.length-1;i++){
           arr[i] = arr[i+1];
       }
       arr.pop();
   }
   //方法2 [1,2,3,4] [1,4,3,4] [1,4,3]
   function remove2(uint _index) public {
    arr[_index] = arr[arr.length -1];
    arr.pop();
   }

   function test() external {
       arr = [1,2,3,4,5];
       remove(2);
       assert(arr[0]==1);
       assert(arr[1]==2);
       assert(arr[2]==4);
   }
}