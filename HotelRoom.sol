// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract HotelRoom {

    enum Statuses { Vacant, Occupied }
    Statuses currentStatus;
    address public owner;

    event Occupy(address _occupant, uint _value);

    constructor() {
        owner = msg.sender;
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant {
        require(currentStatus == Statuses.Vacant, "Currently occupied.");
        _;
    }

    modifier costs(uint _amount) {
        require(msg.value >= _amount, "Not enough Ether provided.");
        _;
    }

    receive() external payable onlyWhileVacant costs(2 ether) {
        currentStatus = Statuses.Occupied;
        payable(owner).transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }
}