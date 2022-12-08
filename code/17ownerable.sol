//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Constructor {
    address public owner;
    constructor() {
        owner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == owner,"not owner");
        _;
    }
    function setOwner(address _newOwner) external  onlyOwner {
        owner = _newOwner;
    }
    function onlyOwnerCanCallIt() external  onlyOwner {}
    function anyoneCallIt() external {}

}