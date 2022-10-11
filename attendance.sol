//Malhar Bangdiwala
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract AttendanceSystem{
    address owner;
    constructor(){
        owner=msg.sender;
    }

    function college(uint lecs) public view returns (string memory){
        require(owner==msg.sender,"Only owner can access this function");
        
        if (lecs>=8){
            return ("Present");
        }
        else if (lecs>=4){
            return ("Half Day");
        }
        else{
            return ("Absent");
        }
    }
}