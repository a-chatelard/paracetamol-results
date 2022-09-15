// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./Ownable.sol";

/**
 * @title The ResultApproval contract.
 * @dev Expose functions and modifiers to manage approved users.
 */
contract ResultApproval is Ownable {
    mapping (address => bool) private _approvals;

    /**
    * @dev Add a user as approved so they can add results to the clinical test.
    */
    function approve(address _approved) external onlyOwner {
        _approvals[_approved] = true;
    }

    /**
     * @dev Remove a user from approval.
     */
    function disapprove(address _dissapproved) external onlyOwner {
        _approvals[_dissapproved] = false;
    }

    /**
     * @dev Throws if user is not included in the approvals list nor is the owner of the contract.
     */
    modifier onlyApproved(address _user) {
        require(_approvals[_user] || _user == owner());
        _;
    }
}