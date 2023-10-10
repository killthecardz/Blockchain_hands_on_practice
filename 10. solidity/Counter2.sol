// SPDX-License-Identifier : MIT
pragma solidity ^0.8.13;

import "./Counter.sol";

contract Counter2 {
    uint value; 
    Counter counter ; // Counter 컨트랙트의 구조를 가지고 있는 counter 상태변수

    constructor() {
        // Counter 인스턴스를 하나 생성
        counter = new Counter();
    }

    function setValue(uint256 _value) public {
        counter.setValue(_value);
    }

    function getValue() public view returns(uint256) {
        return counter.getValue();
    }
}