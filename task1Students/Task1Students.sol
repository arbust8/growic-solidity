pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract Task1Students {

    address public owner;

    mapping(address => Student) public students;

    modifier onlyOwner() {
        require(owner == msg.sender, "Only owner has permission!");
        _;
    }

    struct Student {
        string name;
        uint8 totalMarks;
        uint8 percentage;
    }

    constructor() payable {
        owner = msg.sender;
    }

    function getStudentDetails(address _studentID) public view returns (Student memory) {
        return students[_studentID];
    }

    function register(address _studentID, string memory _name, uint8 _marks, uint8 _percentage) public onlyOwner {
        students[_studentID] = Student(_name, _marks, _percentage);
    }

    // to support receiving ETH by default
    receive() external payable {}
    fallback() external payable {}
}
