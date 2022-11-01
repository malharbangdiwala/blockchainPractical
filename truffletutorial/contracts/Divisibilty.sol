
//Malhar Bangdiwala BE Comps 2019130005
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Divisibility{
    uint divisor;
    constructor(){
        divisor=2;
    }
    function check(uint num1,uint num2,uint num3) public view returns (string memory){
        uint sum=num1+num2+num3;
        if (sum%divisor==0){
            return("Division successful");
        }
        else{
            return("Division unsuccessful");
        }
    }
    function setDivisor(uint num) public returns(string memory){
        if(num==0){
            return ("Divisor cannot be 0");
        }
        else{
            divisor=num;
            return("Divisor set successfully");
        }
    }
}