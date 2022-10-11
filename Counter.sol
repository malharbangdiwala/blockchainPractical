// SPDX-License-Identifier: GPL-3.0
pragma solidity>=0.5.0 <0.9.0;

contract Counter{
    uint public count;

    //Function that returns value of count
    function get() public view returns(uint){
        return count;
    }

    //Function to increment value by 1
    function inc() public{
        count+=1;
    }

    //Function to decrement value by 1. Will fail when count becomes <0
    function dec() public{
        count-=1;
    }
}
