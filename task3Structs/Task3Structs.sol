pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract Task3Structs {

    mapping(address => uint) public balance;

    struct User {
        string name;
        uint age;        
    }

    mapping(address => User) public users;

    function deposit(uint256 amount) public {
        balance[msg.sender] += amount;
    }

    function checkBalance() public view returns (uint) {
        return balance[msg.sender];
    }
    
    function setUserDetails(string calldata _name, uint256 _age) public {
        User storage user = users[msg.sender];
        user.name = _name;
        user.age = _age;
    }

    function getUserDetails() public view returns (string memory, uint) {
        User memory user = users[msg.sender];
        return (user.name, user.age);
    }

    // to support receiving ETH by default
    receive() external payable {}
    fallback() external payable {}
}
