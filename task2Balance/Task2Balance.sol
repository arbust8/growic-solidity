pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract Task1 {

    mapping(address => uint) public balance;

    function deposit(uint256 amount) public {
        balance[msg.sender] += amount;
    }

    function checkBalance() public view returns (uint) {
        return balance[msg.sender];
    }

    // to support receiving ETH by default
    receive() external payable {}
    fallback() external payable {}
}
