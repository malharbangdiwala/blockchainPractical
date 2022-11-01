//Malhar Bangdiwala BE Comps 2019130005
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract CreditLimit{
    uint hardlimit;
    constructor(){
        hardlimit=1000;
    }
    function spend(uint food,uint travel,uint stay) public returns (string memory,uint){
        uint amt=food+travel+stay;
        if (amt>hardlimit){
            return("Transaction fail",hardlimit);
        }
        else{
            hardlimit=hardlimit-amt;
            return("Transaction successful",hardlimit);
        }
    }
    function reset(uint amt) public returns(string memory,uint){
        hardlimit=amt;
        return("Limit reset",hardlimit);
    }
}