//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract DataLocations {
   struct MyStruct {
       uint foo;
       string text;
   }
   mapping(address=>MyStruct) public myStructs;
   //输入参数可以吧memory 换成calldata
   function examples(uint[] calldata y,string calldata s) external returns (uint[] memory) {
       myStructs[msg.sender] = MyStruct({foo:123,text:"bar"});
       MyStruct storage myStruct = myStructs[msg.sender];
       myStruct.text = "foo";
       MyStruct memory readonly = myStructs[msg.sender];
       readonly.foo = 456;

       _internal(y);
       uint[] memory memArr = new uint[](3);
       memArr[0] = 234;
       return memArr;
   }
   function _internal(uint[] calldata y) pure private {
       uint x = y[0];
   }
}
