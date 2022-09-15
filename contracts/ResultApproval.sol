// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./Ownable.sol";

contract ResultApproval is Ownable {
    mapping (address => bool) private _approvals;

    function approve(address _approved) external onlyOwner {
        _approvals[_approved] = true;
    }

    function disapprove(address _dissapproved) external onlyOwner {
        _approvals[_dissapproved] = false;
    }

    modifier onlyApproved(address _user) {
        require(_approvals[_user] || _user == owner());
        _;
    }
}