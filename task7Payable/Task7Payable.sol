pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract Task7Payable {    

    address public owner;

    uint constant private FEE = 20;

    mapping(address => uint) public balance;

    struct User {
        string name;
        uint age;
        uint funds;
    }

    mapping(address => User) public users;

    function deposit() public payable {
        balance[msg.sender] = msg.sender.balance;
    }

    function withdraw(uint _amount) public onlyOwner {
        balance[msg.sender] -= _amount;
    }

    function addFund(uint _amount) public hasEnoughFunds(_amount) meetsFee(_amount) {
        users[msg.sender].funds += _amount;
        emit FundsDeposited(msg.sender, _amount);
    }

    function checkBalance() public view returns (uint) {
        return balance[msg.sender];
    }
    
    function setUserDetails(string calldata _name, uint256 _age) public {
        User storage user = users[msg.sender];
        user.name = _name;
        user.age = _age;
        emit ProfileUpdated(msg.sender);
    }

    function getUserDetails() public view returns (string memory, uint) {
        User memory user = users[msg.sender];
        return (user.name, user.age);
    }
    
    // with this modifier users can't add funds with zero balance (or less balance than the fund amount specified!)
    modifier hasEnoughFunds(uint amount) {
        // require(balance[msg.sender] >= amount, "You don't have enough funds!");
        if (balance[msg.sender] >= amount) { _; } else { revert NotEnoughFunds(); }
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner has permission!");
        _;
    }

    modifier meetsFee(uint amount) {
        // require(amount > FEE, "The amount does not meet the fee cut!");
        if(amount > FEE) { _; } else { revert FeeUnmet(); }
    }

    constructor() payable {
        owner = msg.sender;
    }

    event FundsDeposited(address user, uint256 amount);
    event ProfileUpdated(address user);
    
    error NotEnoughFunds();
    error FeeUnmet();

    // to support receiving ETH by default
    receive() external payable {}
    fallback() external payable {}
}
