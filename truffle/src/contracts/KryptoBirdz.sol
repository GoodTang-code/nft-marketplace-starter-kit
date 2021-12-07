// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract KryptoBirdz is ERC721Connector {
    string public tokenName = 'KryptoBirdz';
    string public tokenSymbol = 'KBIRDZ';

    //Array to store our NFTs
    string [] public kryptoBird; 

    mapping(string => bool) _kbExist; //string is HTML of image

    function mint(string memory _kb) public {

        require(!_kbExist[_kb], "Error - KryptoBirdz exists !");
        
        kryptoBird.push(_kb);               // Push KryptoBird into Array
        uint _id = kryptoBird.length -1;    // Position in Array

        _mint(msg.sender, _id);             // mint from ERC721.sol Function

        _kbExist[_kb] = true;
    }

    constructor () ERC721Connector(tokenName,tokenSymbol) { 
    }
}
