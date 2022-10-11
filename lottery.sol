// SPDX-License-Identifier: MIT
//Malhar Bangdiwala 2019130005
pragma solidity ^0.8.4;

contract Malhar_Lottery{
    address public manager;
    address payable[] public participants;

    constructor(){
        manager = msg.sender;
    }

    modifier onlyOwner(){
        require (manager==msg.sender, "Only Manager can access the function!");
        _;
    }

    receive() external payable{
        require(msg.value == 2 ether);
        participants.push(payable(msg.sender));
    }

    function getBalance() public onlyOwner view returns (uint) {
        return address(this).balance;
    }

    function random() public  view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, participants.length)));
    }
    //Malhar Bangdiwala 2019130005
    function selectWinner() public onlyOwner returns (address){
        require ( participants.length >=3);
        address payable winner;
        uint r = random();
        uint index = r%participants.length;
        winner = participants[index];
        winner.transfer ( getBalance());
        participants = new address payable[](0);
        return winner;
    }

}