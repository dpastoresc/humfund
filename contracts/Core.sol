pragma solidity ^0.5.0;

import "./Winner.sol";

contract Core {

    ProjectCreatedInfo[] public projectsCreated;
    ProjectProposedInfo[] public projectsProposed;
    uint contractBalance = address(this).balance;

    struct ProjectCreatedInfo {
        uint finishTime;
        uint createdTime;
        address company;
        uint value;
    }

    struct ProjectProposedInfo {
        uint estimatedTime;
        address company;
        uint value;
    }

    function recieveFounds() public payable {
        msg.sender.transfer(contractBalance);
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

    function getItemOfProposedProjects(uint index) public view returns (address, uint, uint) {
        ProjectProposedInfo storage project = projectsProposed[index];
        return (project.company, project.estimatedTime, project.value);
    }

    function createProject(uint _finishTime, address _company, uint _requiredValue) internal returns (address) {
        Winner project = new Winner();
        require(contractBalance > _requiredValue, "Insufficent money");
        contractBalance = contractBalance - _requiredValue;
        project.setParamsAndCreate(_finishTime, _company, _requiredValue);
        address c = address(project);
        projectsCreated.push(ProjectCreatedInfo(_finishTime, block.timestamp, _company, _requiredValue));
        return c;
    }
}