//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Structs {
  struct Car {
      string model;
      uint year;
      address owner;
  }
  Car public car;
  Car[] public cars;
  mapping(address=>Car[]) public carsByOwner;
  function example() external  {
      Car memory toyota = Car("toyota",1990,msg.sender);
      Car memory lambo = Car({model:"lamboghini",owner:msg.sender,year:1998});
      Car memory tesla;
      tesla.model = "tesla";
      tesla.year=2000;
      tesla.owner = msg.sender;

      cars.push(toyota);
      cars.push(lambo);
      cars.push(tesla);

      cars.push(Car("Ferrari",2020,msg.sender));
      Car memory _car = cars[0];
      _car.year;
      Car storage _car2 = cars[0];
      _car2.year = 1999;

      delete cars[1];
  }
}
