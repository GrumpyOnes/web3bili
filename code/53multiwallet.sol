//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract MultiSigWallet {
event Deposit(address indexed sender,uint amount);
event Submit(uint indexed txId);
event Approve(address indexed owner,uint indexed txId);
event Revoke(address indexed owner,uint indexed txId);
event Execute(uint indexed txId);

address[] public owners;
mapping(address=>bool) public isOwner;
uint public required;

struct Transaction {
  address to;
  uint value;
  bytes data;
  bool executed;
}
Transaction[] public transactions;
mapping(uint=>mapping(address=>bool)) public approved;

constructor(address[] memory _owners,uint _required){
  for(uint i=0;i<_owners.length;i++){
    require(address(0)!=_owners[i],"0 address not ok");
    require(!isOwner[_owners[i]],"owner is not unique");
    owners.push(_owners[i]);
    isOwner[_owners[i]] = true;
  }
  require(_required>0 && _owners.length>_required,"required should less than owner");
  required = _required;
}
receive() external payable{
  emit Deposit(msg.sender,msg.value);
}
modifier onlyOwner(){
  require(isOwner[msg.sender],"not owner");
  _;
}
modifier txExists(uint _txId){
  require(_txId<transactions.length,"not exist");
  _;
}
modifier notApproved(uint _txId){
  require(!approved[_txId][msg.sender],"has approved");
  _;
}
modifier notExecuted(uint _txId){
  require(!transactions[_txId].executed,"has executed");
  _;
}
function submit(address _to,uint _value,bytes calldata _data) external onlyOwner {
  Transaction memory trans = Transaction(_to,_value,_data,false);
  transactions.push(trans);
  emit Submit(transactions.length-1);
}
function approve(uint _txId) external onlyOwner txExists(_txId) notApproved(_txId) notExecuted(_txId) {
  approved[_txId][msg.sender] = true;
  emit Approve(msg.sender,_txId);
}
function _getApprovalCount(uint _txId) private view returns(uint count) {
  for(uint i;i<owners.length;i++){
    if(approved[_txId][owners[i]]){
      count+=1;
    }
  }
}
function execute(uint _txId) external txExists(_txId) notExecuted(_txId) {
  require(_getApprovalCount(_txId)>=required,"not apporve enough");
  Transaction storage trans = transactions[_txId];
  trans.executed = true;
  (bool success,) = trans.to.call{value:trans.value}(trans.data);
  require(success,"execute failed");
  emit Execute(_txId);

}
function revoke(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId) {
  require(approved[_txId][msg.sender],"not approval");
  approved[_txId][msg.sender] = false;
  emit Revoke(msg.sender,_txId);
}

}