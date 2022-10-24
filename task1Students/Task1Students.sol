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
    
    modifier notRegistered(address _addr) {
        Student memory _student = students[_addr];
        require(!_student.isRegistered, "Address already registered!");
        _;
    }    

    struct Student {
        string name;
        uint8 totalMarks;
        uint8 percentage;
        bool isRegistered;
    }

    constructor() payable {
        owner = msg.sender;
    }

    function getStudentDetails(address _studentID) public view returns (Student memory) {
        return students[_studentID];
    }

    function register(address _studentID, string memory _name, uint8 _marks, uint8 _percentage) public onlyOwner notRegistered(_studentID) {
        students[_studentID] = Student(_name, _marks, _percentage, true);
    }

    // to support receiving ETH by default
    receive() external payable {}
    fallback() external payable {}
}
