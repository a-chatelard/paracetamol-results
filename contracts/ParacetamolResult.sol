// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./ResultApproval.sol";

/**
 * @title The ParacetamolResult contract
 * @dev It allows the count of positive and negative results during clinical tests.
 * In the end, the contract can be closed to prevent results to be added afterwards.
 * The current success pourcentage can be obtained anytime.
 */
contract ParacetamolResult is ResultApproval {
    
    event NewResult(string patientRef);

    event ResultsClosed(uint totalResult);

    struct Result {
        string patientRef;
        string lotId;
        bool result;
    }
    Result[] private _results;
    bool private _closed = false;

    mapping(string => bool) private _validatedPatients;

    /**
     * @dev Add a new result the list of results.
     * The contract must not be closed in order to add new results and the patient's result must not already be added.
     * @param _patientRef the reference of the tested patient.
     * @param _lot the lot where the tested patient is included.
     * @param _result the result of the test (true : success or false : failure).
     */
    function addResult(string memory _patientRef, string memory _lot, bool _result) external onlyApproved(msg.sender) {
        require(!_closed);
        require(!_validatedPatients[_patientRef]);
        _results.push(Result(_patientRef, _lot, _result));
        _validatedPatients[_patientRef] = true;
        emit NewResult(_patientRef);
    }

    /**
     * @dev Get a snapshot of the total result of the clinical test.
     * @return 0 if no result has been added. Otherwise A number included 0 and 100 (pourcentage representation).
     */
    function getResultSnapshot() public view returns (uint) {
        uint total = 0;
        if (_results.length == 0) {
            return 0;
        }
        for (uint i = 0; i < _results.length; i++) {
            if (_results[i].result) {
                total++;
            }
        }
        return total * 100 / _results.length;
    }

    /**
     * @dev Definitly close the clinical test so no result can be added afterward.
     * The clinical test cannot be re-opened.
     */
    function close() external onlyOwner {
        require(!_closed);
        _closed = true;
        uint totalResult = getResultSnapshot();
        emit ResultsClosed(totalResult);
    }   
}