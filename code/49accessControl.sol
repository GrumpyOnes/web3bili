//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract AccessControl {
  event GradeAccess(address _account,bytes32 _access);
  event RevokeAccess(address _account,bytes32 _access);
  mapping(bytes32 =>mapping(address=>bool)) public roles;
  bytes32 public constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
  bytes32 public constant USER = keccak256(abi.encodePacked("USER"));

constructor(){
  roles[ADMIN][msg.sender] = true;
}
  function _gradeAccess(address _account,bytes32 _access) internal {
    roles[_access][_account] = true;
  }

  modifier HasAccess(bytes32 _access){
    require(roles[_access][msg.sender],"hasnt roles");
    _;
  }
  function gradeAccess(address _account,bytes32 _access) external HasAccess(ADMIN) {
    _gradeAccess( _account, _access);
    emit GradeAccess(_account, _access);
  }
  function revokeAccess(address _account,bytes32 _access) external HasAccess(ADMIN) {
    roles[_access][_account] = false;
    emit RevokeAccess(_account, _access);
  }
}