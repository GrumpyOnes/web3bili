//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IERC721 {
  function transferFrom(
    address _from,
    address _to,
    uint _nfgId
  ) external;
}

contract DutchAuction {
  uint private constant DURATION = 7 days;
  IERC721 public immutable nft;
  uint public immutable nftId;
  address payable public  immutable seller;
  uint public immutable startPrice;
  uint public immutable startAt;
  uint public immutable expiresAt;
  uint public immutable discountRate;
  constructor(
    uint _startingPrice,
    uint _discountRate,
    address _nft,
    uint _nftId
  ){
    seller = payable(msg.sender);
    startPrice = _startingPrice;
    startAt = block.timestamp;
    expiresAt = block.timestamp + DURATION;
    discountRate = _discountRate;
    require(_startingPrice>=discountRate*DURATION,"starting price < min ");
    nft = IERC721(_nft);
    nftId = _nftId;
  }

  function getPrice() public view returns(uint currprice) {
    uint timeElapsed = block.timestamp - startAt;
    currprice = startPrice - timeElapsed*discountRate;
  }

  function buy() external payable {
    require(block.timestamp< expiresAt,"auction expired");
    uint pirce = getPrice();
    require(msg.value >=pirce,"eth <price");
    
    nft.transferFrom(seller, msg.sender, nftId);
    uint refund = msg.value - pirce;
    if(refund>0){
      payable(msg.sender).transfer(refund);
    }
    selfdestruct(seller);
  }
}
