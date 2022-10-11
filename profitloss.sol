//Malhar Bangdiwala 2019130005
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract PLCalculator{
    address owner;
    constructor(){
        owner=msg.sender;
    }

    function calculate(uint cp,uint sp) public view returns (string memory,uint){
        require(owner==msg.sender,"Only owner can access this function");
        if (sp>cp){
            return ("Profit",sp-cp);
        }
        else if(sp==cp) {
            return ("No Profit No Loss",0);
        }
        else{
            return ("Loss",cp-sp);
        }
    }
}