//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
//virturl 可覆盖合约
contract E {
event Log(string message);
function foo() public virtual {
    emit Log("E.foo");
}
function bar() public virtual {
    emit Log("E.bar");
}
}

contract F is E {
function foo() public override virtual  {
    emit Log("F.foo");
    E.foo();
}
function bar() public override virtual{
    emit Log("F.bar");
    super.foo();
    //E.bar V.bar
}
}

contract G is E {
function foo() public override virtual {
    emit Log("G.foo");
}
function bar() public override virtual {
    emit Log("G.bar");
}
}

contract H is F,G {
function foo() public override(F,G)  {
    emit Log("H.foo");
    F.foo();
}
function bar() public override(F,G) {
    emit Log("H.bar");
    super.bar();
}
}




