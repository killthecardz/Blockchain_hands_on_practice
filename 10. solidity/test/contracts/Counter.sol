// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter{
    uint256 private value;

    function increment() public {
        value += 1;
    }

    function decrement() public {
        value -= 1;
    }

    function getValue() public view returns(uint256) {
        return value;
    }
}