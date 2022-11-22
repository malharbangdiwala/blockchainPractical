//Malhar Bangdiwala BE Comps 2019130005
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Crowdfunding{
    mapping (address =>uint) public contributor;
    address public manager;
    uint public minimumContribution;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noOfContributors;
    struct Request{
        string eventName;
        address payable recipient;
        uint value;
        bool completed;
        uint noOfVoters;
        mapping (address=>bool) voters;
    }
    mapping(uint=>Request) public requests;
    uint public numRequests;

    constructor(uint _target, uint _deadline){
        target=_target;
        deadline=block.timestamp+_deadline;
        minimumContribution=100 wei;
        manager=msg.sender;
    }

    function sendEth() public payable{
        require(block.timestamp<deadline,"The deadline has passed");
        require(msg.value>=minimumContribution,"Minimum contribution not met");
        if (contributor[msg.sender]==0){
            noOfContributors++;
        }
        contributor[msg.sender]+=msg.value;
        raisedAmount+=msg.value;
    }
    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }
    function refund() public{
        require(block.timestamp>deadline && raisedAmount<target, "Not eligible for refund");
        require(contributor[msg.sender]>0);
        address payable user = payable(msg.sender);
        raisedAmount-=contributor[msg.sender];
        user.transfer(contributor[msg.sender]);
        contributor[msg.sender]=0;
        noOfContributors--;
    }
    modifier OnlyManager(){
        require(msg.sender==manager, "Only manager can call this function");
        _;
    }

    function createRequests(string memory _eventName, address payable _recipient, uint _value) public OnlyManager {
        Request storage newRequest = requests[numRequests];
        numRequests++;
        newRequest.eventName = _eventName;
        newRequest.recipient = _recipient;
        newRequest.value = _value;
        newRequest.completed = false;
        newRequest.noOfVoters=0;
    }

    function voteRequest(uint _requestNo) public{
        require(contributor[msg.sender]>0,"You must be a contributor");
        Request storage thisRequest=requests[_requestNo];
        require(thisRequest.voters[msg.sender]==false, "You have already voted");
        thisRequest.voters[msg.sender]=true;
        thisRequest.noOfVoters++;
    }

    function makePayment(uint _requestNo) public OnlyManager{
        require(raisedAmount>=target);
        Request storage thisRequest=requests[_requestNo];
        require(thisRequest.completed==false, "This request has been completed");
        require(thisRequest.noOfVoters>noOfContributors/2, "Majority does not support");
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed=true;

    }

}