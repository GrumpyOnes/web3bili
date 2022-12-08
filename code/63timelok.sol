//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Timelock {
  address public owner;
  uint256 public minDelay = 60; // 60s
  uint256 public maxDelay = 600; // 600s
  uint256 public constant GRACE_PERIOD = 100;

  event Queue(
        bytes32 txId,
        address indexed _target,
        uint256 _value,
        bytes _data,
        uint256 _timestamp
    );
  event Execute(
        bytes32 txId,
        address indexed _target,
        uint256 _value,
        bytes _data,
        uint256 _timestamp
    );
  event BeCanceled(bytes32 txId);
  error TimestampNotInRangeError();
  error AlreadyQueuedError(address,bytes32);
  error NotExistQueuedError(address,bytes32);
  error ExecuteError(bytes32);
  error HasExpired(bytes32);
  error TimestampNotPassedError(uint256,bytes32);
  error TimestampExpired(uint256,bytes32);
  error HasBeenCanceled(bytes32);
  receive() external  payable {}
  constructor(){
    owner = msg.sender;
  }
  modifier onlyowner() {
    require(msg.sender==owner,"not owner");
    _;
  }
  function getHash(
        address _target,
        uint256 _value,
        bytes calldata _data,
        uint256 _timestamp
    ) public pure returns (bytes32) {
        return keccak256(abi.encode(_target, _value, _data, _timestamp));
    }
  mapping(address=>mapping(bytes32=>bool)) public queueId;
  mapping(bytes32 =>bool) public queued;
  function queue(
    address _target,
    uint _value,
    bytes calldata _data,
    uint256 _timestamp
  ) external{
    if(_timestamp<block.timestamp+minDelay || 
    _timestamp>block.timestamp+ maxDelay){
      revert TimestampNotInRangeError();
    }
    bytes32 txId = getHash(_target,_value,_data,_timestamp);
    if(queueId[msg.sender][txId]){
      revert AlreadyQueuedError(msg.sender, txId);
    }
    queueId[msg.sender][txId] = true;
    emit Queue(txId,_target,_value,_data,_timestamp);

  }
  function execute(address _target,
    uint _value,
    string calldata _func,
    bytes calldata _data,
    uint256 _timestamp
    ) external payable returns(bytes memory){

      bytes32 txId = getHash(_target,_value,_data,_timestamp);
    if(queued[txId]){
      revert HasBeenCanceled(txId);
    }
    if(!queueId[msg.sender][txId]){
      revert NotExistQueuedError(msg.sender,txId);
    }
    if(block.timestamp<_timestamp){
      revert TimestampNotPassedError(block.timestamp,txId);
    }
    if(block.timestamp>_timestamp+GRACE_PERIOD){
      revert TimestampExpired(block.timestamp,txId);
    }
    bytes memory mydata;
    if(bytes(_func).length>0){
      mydata = abi.encodeWithSignature(_func); 
      // abi.encodePacked(
      //   bytes4(keccak256(bytes(_func))),_data
      // );
    }else{
      mydata = _data;
    }
    (bool success,bytes memory data) = _target.call{value:_value}(mydata);
    require(success,"call failed");
        if (!success) {
          revert ExecuteError(txId);
        }
        //queueId[msg.sender][txId] = false;
        emit Execute(txId, _target, _value, _data, _timestamp);
        return data;
    }

    function cancel(bytes32 txId) onlyowner external {
      if(queued[txId]){
        revert HasBeenCanceled(txId);
      }
      emit BeCanceled(txId);
    }

}

contract TestTimelock {
  address public timelock;
  constructor(address _timelock){
    timelock = _timelock;
  }
  function test() payable external returns (uint256){
    require(msg.sender == timelock);
    return 345;
  }
  function getTimestamp() external view returns (uint256){
    return block.timestamp;
  }

  function compare() external pure returns (bytes memory,bytes memory){
    bytes memory n1 = abi.encodeWithSignature("test()"); 
    bytes memory n2 = abi.encodePacked(
        bytes4(keccak256(bytes("test()")))
      );
      return (n1,n2);
      //两者相同
  }
}