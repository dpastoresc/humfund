pragma solidity ^0.5.0;

import "./Core.sol";

library address_make_payable {
   function make_payable(address x) internal pure returns (address payable) {
      return address(uint160(x));
   }
}

contract Winner {

    uint public finishTime;
    uint public value;
    address public company;
    uint createdTime;

    using address_make_payable for address;

    function setParamsAndCreate(uint _finishTime, address _company, uint _balance) external {
        finishTime = _finishTime;
        company = _company;
        value = _balance;
        createdTime = block.timestamp;
    }

    function getProjectPrice() public view returns (uint) {
        return value;
    }

    function finishProject(address _company, uint _valueInEther) internal {
        address payable projectMaker = _company.make_payable();
        projectMaker.transfer(_valueInEther);
    }

}