pragma solidity ^0.5.0;

import "./Core.sol";
import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Voter is Core {

    using SafeMath for uint8;

    function winningProposal() internal view returns (uint winningProposal_) {
        uint winningVoteCount = 0;
        for (uint p = 0; p < projectsProposed.length; p++) {
            if (projectsProposed[p].votes > winningVoteCount) {
                winningVoteCount = projectsProposed[p].votes;
                winningProposal_ = p;
            }
        }
    }

    function retrieveWinner() public {
        uint winnerIndex = winningProposal();
        ProjectProposedInfo memory winner = projectsProposed[winnerIndex];
        uint32 finishTime = uint32(block.timestamp) + uint32(winner.estimatedTime);
        createProject(finishTime, winner.company, winner.value);
    }

    function voteForProject(uint _index, bool _vote) public {
        if (_vote) {
            projectsProposed[_index].votes = uint8(projectsProposed[_index].votes.add(1));
        }
    }

}