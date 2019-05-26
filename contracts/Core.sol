pragma solidity ^0.5.0;

import "./Winner.sol";

contract Core {

    ProjectCreatedInfo[] public projectsCreated;
    ProjectProposedInfo[] public projectsProposed;
    address[] public donators;
    uint public lengthOfProposedProjects = 0;

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
        uint8 id;
        uint8 votes;
    }

    function() external payable { }

    function recieveFounds() public payable {
        donators.push(msg.sender);
        address(this).transfer(msg.value);
    }

    function getLengthOfDonators() public view returns (uint) {
        return donators.length;
    }

    function checkDonator(uint index) public view returns (address) {
        return donators[index];
    }

    function lengthOfCreatedProjects() public view returns (uint) {
        return projectsCreated.length;
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
        ProjectProposedInfo memory project = ProjectProposedInfo(_company, _value, _estimatedTime, uint8(lengthOfProposedProjects), 0);
        lengthOfProposedProjects++;
        projectsProposed.push(project);
    }

    function createProject(uint32 _finishTime, address _company, uint _requiredValue) internal returns (address) {
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