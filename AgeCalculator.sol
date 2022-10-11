// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.4.0;

contract AgeCalculator{
    uint year;
    function getAge() public view returns(int){
        uint curyear=2022;
        if (year>curyear){
            return -1;
        }
        else{
            return int(curyear-year);
        }
    }
    function setDOB(uint _year) public{
        year=_year;
    }
}
