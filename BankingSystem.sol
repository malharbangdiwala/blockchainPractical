//Malhar Bangdiwala BE Comps 2019130005
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;
pragma abicoder v2;
import "@openzeppelin/contracts/utils/Strings.sol";

contract BankingSystem{// Contract to implement banking functions
    mapping(address => uint) public balance; // To store balances
    mapping(address=>string []) public transactionHistory; //To store transaction records
    
    uint minBalance;//To store minimum balance required in an account
    
    address manager;// To store managers address
    uint noOfCustomers; //To store number of customers
    uint amountInAccount;//To store total amount in bank account

    uint minFDAmount;//Minimum amount required to create FD
    uint fdTime;//Time taken for FD to mature
    uint fdInterestRate;//Interest rate in fd
    uint totalFDAmount;//Total amount stored as FD
    mapping(address => uint[2]) public fd;//Address will store amount, time after which fd is completed

    constructor(uint _minBalance,uint _fdTime,uint _fdInterestRate,uint _minFDAmount){
        //Initialise minimum amount required to keep account active, manager of bank, Time for FD maturity and its interest rate
        minBalance=_minBalance*1 wei;
        fdTime=_fdTime;
        fdInterestRate=_fdInterestRate;
        manager=msg.sender;
        minFDAmount=_minFDAmount;
    }

    modifier onlyManager(){
        //Modifier to enable functions that can only be viewed ny manager
        require(msg.sender==manager,"Only manager can access this function");
        _;
    }

    function createFD() public payable{
        // Function to create FD of given amount, For simplicity only 1 active FD can be made per user and amount has to be paid separately(i.e. not taken from deposited amount)
        require(msg.value>minFDAmount,"Minimum amount has not been passed");
        require(msg.sender!=manager,"Manager cannot open account");
        require(balance[msg.sender]>=minBalance,"No account found");
        require(fd[msg.sender][0]==0,"FD already made");
        fd[msg.sender]=[msg.value,block.timestamp+fdTime];
        totalFDAmount+=msg.value;
    }

    function getFDReturns() public{
        // Function to get returns of FD. For simpilicity, the returns get added to the customers bank account.
        require(msg.sender!=manager,"Manager cannot open account");
        require(balance[msg.sender]>=minBalance,"No account found");
        require(fd[msg.sender][0]!=0,"No FD made");
        require(block.timestamp>=fd[msg.sender][1],"FD has not matured yet");
        totalFDAmount-=fd[msg.sender][0];
        uint amountReceived=fd[msg.sender][0]+fd[msg.sender][0]*fdInterestRate/100;
        amountInAccount+=amountReceived;
        balance[msg.sender]+=amountReceived;
        string memory word=string.concat("Wei Received from FD ",Strings.toString(amountReceived));
        transactionHistory[msg.sender].push(word);
        fd[msg.sender]=[0,0];
    }

    function deposit() public payable {
        //Function to allow customers to deposit in bank account
        require(msg.value>0,"No amount has been passed");
        require(msg.sender!=manager,"Manager cannot open account");
        if (balance[msg.sender]==0){ //If customer is new customer
            require(msg.value>=minBalance,"Minimum amount to open account not passed");
            noOfCustomers+=1;
        }
        balance[msg.sender] += msg.value;
        amountInAccount+=msg.value;
        string memory word=string.concat("Wei Deposited ",Strings.toString(msg.value));
        transactionHistory[msg.sender].push(word);
    }

    function withdraw(uint amount) public payable{
        //Function to withdraw amount from account
        amount*=1 wei;
        require(minBalance<= balance[msg.sender]-amount,"Insufficient funds");
        balance[msg.sender] -= amount;
        (payable(msg.sender)).transfer(amount);
        amountInAccount-=amount;
        string memory word=string.concat("Wei Withdrawn ",Strings.toString(amount));
        transactionHistory[msg.sender].push(word);
    }

    function transfer(address receiver,uint amount) public{
        //Function to transfer amount from 1 account to another
        amount*=1 wei;
        require(receiver!=msg.sender,"Cannot transfer message to self");
        require(minBalance<= balance[msg.sender]-amount,"Insufficient funds");
        require(balance[receiver]>0,"Bank account does not exist");
        balance[receiver]+=amount;
        balance[msg.sender]-=amount;
        string memory word1=string.concat("Wei Transferred ",Strings.toString(amount));
        transactionHistory[msg.sender].push(word1);
        string memory word2=string.concat("Wei Received ",Strings.toString(amount));
        transactionHistory[receiver].push(word2);
    }

    function checkTransactionHistory() public view returns (string[] memory){
        //Function to check history customer's transactions
        require(balance[msg.sender]>=minBalance,"No account found");
        return transactionHistory[msg.sender];
    }

    function checkBalance() public view returns (uint256){
        //Function to check bank balance
        require(balance[msg.sender]>=minBalance,"No account found");
        return balance[msg.sender];
    }

    function closeAccount() public payable{
        //Function to close account in bank
        require(balance[msg.sender]>=minBalance,"No account found");
        (payable(msg.sender)).transfer(balance[msg.sender]);
        amountInAccount-=balance[msg.sender];
        balance[msg.sender]=0;
        noOfCustomers--;
    }

    function checkNoOfCustomer()public onlyManager view returns(uint){
        //Manager can check how many accounts are present in bank
        return noOfCustomers;
    }

    function checkAmountInBank()public onlyManager view returns(uint,uint){
        //Manager can check total amount present in the bank
        return (amountInAccount,totalFDAmount);
    }

}