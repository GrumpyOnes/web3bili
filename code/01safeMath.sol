//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract SafeMath {
    function testUnderflow() public pure returns (uint) {
        uint x=0;
        x--;
        return x;
    }
    function testUnderflowUncheck() public pure returns (uint) {
        uint x=0;
        unchecked{x--;}
        return x;
    }
}