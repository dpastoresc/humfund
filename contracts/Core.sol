pragma solidity ^0.5.0;

import "./Winner.sol";
// Core.deployed().then(instance => { app = instance })
// web3.eth.defaultAccount = "0xb10aFbb40E46FFe52B136b8C123DDd00833C65B0"
// app.recieveFounds({ value: web3.utils.toWei('1') })
contract Core {

    ProjectCreatedInfo[] public projectsCreated;
    ProjectProposedInfo[] public projectsProposed;

    struct ProjectCreatedInfo {
        address company;
        uint value;
        uint32 finishTime;
        uint32 createdTime;
    }

    struct ProjectProposedInfo {
        address company;
        uint value;
        uint32 estimatedTime;
        uint8 votes;
    }

    function() external payable { }

    function recieveFounds() public payable {
        address(this).transfer(msg.value);
    }

    function getLengthOfCreatedProjects() public view returns (uint) {
        return projectsCreated.length;
    }

    function getLengthOfProposedProjects() public view returns (uint) {
        return projectsProposed.length;
    }

    function getItemOfCreatedProjects(uint index) public view returns (address, uint, uint, uint) {
        ProjectCreatedInfo storage project = projectsCreated[index];
        return (project.company, project.finishTime, project.createdTime, project.value);
    }

    function getItemOfProposedProjects(uint index) public view returns (address, uint, uint, uint) {
        ProjectProposedInfo storage project = projectsProposed[index];
        return (project.company, project.estimatedTime, project.value, project.votes);
    }

    function proposeProject(uint32 _estimatedTime, address _company, uint _value) external {
        projectsProposed.push(ProjectProposedInfo(_company, _value, _estimatedTime, 0));
    }

    function createProject(uint32 _finishTime, address _company, uint _requiredValue) public returns (address) {
        uint contractBalance = address(this).balance;
        Winner project = new Winner();
        require(contractBalance > _requiredValue, "Insufficent money");
        contractBalance = contractBalance - _requiredValue;
        project.setParamsAndCreate(_finishTime, _company, _requiredValue);
        address c = address(project);
        projectsCreated.push(ProjectCreatedInfo(_company, _requiredValue, _finishTime, uint32(block.timestamp)));
        return c;
    }
}