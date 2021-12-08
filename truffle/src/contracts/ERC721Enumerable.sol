// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';
import "./interfaces/IERC721Enumerable.sol";

contract ERC721Enumerable is ERC721, IERC721Enumerable {

    uint256[] private _allTokens;

    //Create Tracking Variable
    //mapping from tokenId => index-in _allTokens array
    mapping(uint256 => uint256) private _allTokenIndex;

    //mapping of Owner => List of all owner token ids
    mapping(address => uint256[]) private _ownedTokens;

    //mappting from tokenId => Owner-Token-index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokenIndex;

    //----------------------------------------------------------------------------------- Standard Function
    constructor(){
        _registerInterface(bytes4(
            keccak256('totalSupply(bytes4)')^
            keccak256('tokenByIndex(bytes4)')^
            keccak256('tokenOfOwnerByIndex(bytes4)')
        ));
    }

    //return total supply of the _allToken Array
    function totalSupply() public override view returns (uint256){
        return _allTokens.length;
    }
    
    function tokenByIndex(uint256 _index) public override  view returns (uint256){
        //the index is not out of bound
        require(_index < totalSupply(), 'Global index is out of bound');
        return _allTokens[_index];
    }

    function tokenOfOwnerByIndex(address _owner, uint256 _index) public override view returns (uint256){
        //The index is not out of bound
        require(_index < balanceOf(_owner), 'global index is out of bound');
        return _ownedTokens[_owner][_index];
    }
    
    //----------------------------------------------------------------------------------- Helper Function

    // Override Function from ERC721.sol
    function _mint(address to, uint256 tokenId) internal override (ERC721) {
        super._mint(to, tokenId); 
        _addTokenToAllTokenEnumeration(tokenId);
        _addTokenToOwnerEnumeration(to, tokenId);
    }
    function _addTokenToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokenIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    //add tokens to the _alltokens array and set the position of the token index
    function _addTokenToAllTokenEnumeration(uint256 tokenId) private {
        _allTokenIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }


}