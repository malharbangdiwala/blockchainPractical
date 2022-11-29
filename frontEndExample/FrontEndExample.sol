//Malhar Bangdiwala BE Comps 2019130005
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract FrontEndExample{
    string name;
    string college;
    string email;
    uint phone;
    function set(string memory _name, string memory _college, string memory _email, uint _phone) public{
        name=_name;
        college=_college;
        email=_email;
        phone=_phone;
    }
    function get()public view returns(string memory,string memory,string memory,uint){
        return(name,college,email,phone);
    }
}
