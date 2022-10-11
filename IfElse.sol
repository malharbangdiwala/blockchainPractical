// SPDX-License-Identifier: GPL-3.0
pragma solidity>=0.7.0 <0.9.0;

contract ifElseExample{
    uint a;
    uint b;
    uint c;
    uint d;
    address owner;

    constructor(){
        owner=msg.sender;
    }

    modifier onlyOwner(){
        require( owner ==msg.sender, "only owner can access");
        _;
    }

    function setMessage(uint _a, uint _b, uint _c, uint _d) public onlyOwner{
        a= _a;
        b= _b;
        c= _c;
        d= _d;
    }

    function get() public view onlyOwner returns(uint){
        if( a>b && a>c && a>d){
            return (a);
        }
        else if( b>a && b>c && b>d){
            return (b);

        }
        else if (c>a && c>b && c>d){
            return (c);
        }
        else{
            return (d);
        }
    }
}
