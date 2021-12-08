// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './interfaces/IERC165.sol';

contract ERC165 is IERC165 {

    constructor(){
        _registerInterface(bytes4(keccak256('supportsInterface(bytes4)')));
    }

    // hash table to keep tract of contract fingerprint data
    // of byte function conversions
    mapping(bytes4 => bool) private _supportInterfaces;

    function supportsInterface(bytes4 interfaceId) external override view returns (bool) {
        return _supportInterfaces[interfaceId];
    }

    // registering the interface (comes from within)
    function _registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff, 'ERC165: Invalid Interface');
        _supportInterfaces[interfaceId] = true;
    }

}