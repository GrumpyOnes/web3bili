//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Event {
 event Log(string message,uint val);
 event IndexedLog(address indexed sender,uint val);
 event Message(address indexed _from,address indexed _to,string message);
 function example() external {
     emit Log("foo",1234);
     emit IndexedLog(msg.sender,789);
 }

}
