//Malhar Bangdiwala BE Comps 2019130005
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract LoopingSystem{
    function looper(uint lim) public pure returns (uint){
        uint sum=0;
        for(uint i=1;i<=lim;i++){
            sum+=i;
        }
        return sum;
    }
}