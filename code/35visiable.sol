//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
//visiability
//private - only inside contract
//internal - only inside and child contract
//public - insid and outside contract
//external - only from outside contract
contract VisibilityBase {
    uint private x=0;
    uint internal y = 1;
    uint public z=2;
    function privateFunc() private pure returns (uint){
        return 100;
    }
    function internalFunc() internal pure returns (uint) {
        return 101;
    }
    function publicFunc() public pure returns (uint) {
        return 102;
    }
    function externaFunc() external pure returns (uint){
        return 103;
    }

    function example() external view{
        x+y+z; //都可以看到
        privateFunc();
        internalFunc();
        publicFunc();
        this.externaFunc();

    }
}
contract Child is VisibilityBase{
    function example2() external view {
        y+z;
        internalFunc();
        publicFunc();
    }
}

