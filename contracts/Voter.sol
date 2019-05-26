pragma solidity ^0.5.0;

import "./Core.sol";
import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Voter is Core {

    Core manager;
    using SafeMath for uint8;

    function checkProject() public {
        manager.proposeProject(1 days, address(0xe4493ae993e8ffc9fd191c1bcb408ae7c8b01129dc7e880c89d72b31dd6c6230), 2);
    }

    function voteForProject(uint index, bool vote) internal {
        if (vote) {
            ProjectProposedInfo storage projectChoosed = projectsProposed[index];
            projectChoosed.votes = uint8(projectChoosed.votes.add(1));
        } else {
            ProjectProposedInfo storage projectChoosed = projectsProposed[index];
            projectChoosed.votes = uint8(projectChoosed.votes.sub(1));
        }
    }

}