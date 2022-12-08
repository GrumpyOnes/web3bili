//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract FunctionModifier {
    bool public paused;
    uint public count;
    function setPause(bool _paused) external {
        paused = _paused;
    }
    modifier whenNotPaused(){
        require(!paused,"paused");
        _;
    }
     modifier cap(uint _x){
        require(_x<100,"x>=100");
        _;
    }
    function inc(uint _x) external whenNotPaused cap(_x){
        count+=_x;
    }
    function dec(uint _x) external whenNotPaused cap(_x){
        count-=_x;
    }

    
}