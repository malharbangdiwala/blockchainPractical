// SPDX-License-Identifier: GPL-3.0
pragma solidity>=0.7.0;

contract Calculator{
    uint result;
    function add( uint _a, uint _b) public{
        result= _a+ _b;
    }

    function sub( uint _a, uint _b) public{
        result= _a - _b;
    }

    function multiply( uint _a, uint _b) public{
        result= _a * _b;
    }

    function divide( uint _a, uint _b) public{
        result= _a / _b;
    }

    function finalresult() public view returns(uint){
        return result;
    }
}
