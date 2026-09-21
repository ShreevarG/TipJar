// SPDX-License-Identifier: MIT

// here, pragma is the instruction, solidity is the language, and ^0.8.20 is the version
pragma solidity ^0.8.20;

//importing Ownable(functionality for Ownership) from OpenZeppelin Contracts, which I downloaded using Bash
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

//creating a contract called TipJar that inherits Ownable contract
contract TipJar is Ownable {
    //creating a mapping, like a HashMap in Java, and recording addresses and respective amounts tipped
    mapping(address => uint256) private tipped;
    //a 256-bit unsigned integer that cannot be directly accessed through Solidity
    uint256 private received;

    //declaring an event/log to the blockchain containing the address, amount, and new total
    event Tipped(
        address indexed from,
        uint256 amount,
        uint256 newTotal
    );

    //making the wallet that deployed the TipJar the owner of the contract
    constructor() Ownable(msg.sender) {}

    //creating a function deposit() using 'payable' which allows us to send ETH along with the function call
    function deposit() external payable {
        //checking that the amount tipped is greater than 0
        require(msg.value > 0, "Tip must be greater than zero");

        //recording how much a particular address has tipped
        tipped[msg.sender] += msg.value;
        //recording how much everyone has tipped in totality
        received += msg.value;

        //calling/emitting the event which logs the address, amount, and new total
        emit Tipped(msg.sender, msg.value, tipped[msg.sender]);
    }

    //getter method to find total ETH tipped by a particular address
    //'view' is for reading the blockchain state, not modifying it
    function totalTipped(address account) external view returns (uint256) {
        return tipped[account];
    }

    //getter method to find total ETH tipped in totality
    function totalReceived() external view returns (uint256) {
        return received;
    }

    //creating a function withdraw() where 'onlyOwner' ensures that only current owner of contract can execute this
    function withdraw() external onlyOwner {
        //'payable' convert the owner's address into a payable address
        //'transfer' transfer all ETH held by this contract to the current owner's wallet
        payable(owner()).transfer(address(this).balance);
    }
}