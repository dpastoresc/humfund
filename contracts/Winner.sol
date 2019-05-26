pragma solidity ^0.5.0;

import './Core.sol';

contract Winner {
    uint public finishTime;
    uint public value;
    address public company;
    uint createdTime;

    function setParamsAndCreate(uint _finishTime, address _company, uint _balance) external {
        finishTime = _finishTime;
        company = _company;
        value = _balance;
        createdTime = block.timestamp;
    }

    function getProjectPrice() public view returns (uint) {
        return value;
    }

}