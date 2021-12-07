// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

contract ERC721Enumerable is ERC721{

    uint256[] private _allTokens;

    //Create Tracking Variable
    //mapping from tokenId => index-in _allTokens array
    mapping(uint256 => uint256) private _allTokenIndex;

    //mapping of Owner => List of all owner token ids
    mapping(address => uint256[]) private _ownedTokens;

    //mappting from tokenId => Owner-Token-index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokenIndex;

    /// @notice Count NFTs tracked by this contract
    /// @return A count of valid NFTs tracked by this contract, where each one of
    ///  them has an assigned and queryable owner not equal to the zero address

    //return total supply of the _allToken Array
    function totalSupply() public view returns (uint256){
        return _allTokens.length;
    }

    //function tokenByIndex(uint256 _index) external view returns (uint256);

    //function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256);

    // Override Function from ERC721.sol
    function _mint(address to, uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId); 
        // a. add Token to the owner
        // b. add token to our total supply - allTokens

        _addTokenToAllTokenEnumeration(tokenId);
        _addTokenToOwnerEnumeration(to, tokenId);

    }
    function _addTokenToOwnerEnumeration(address to, uint256 tokenId) private {
        // 1. add address and tokenId to the _ownedTokens
        // 2. ownedTokenIndex tokenId set to address of ownedTokens positiion
        // 3. we want to execute the function with minting
        _ownedTokenIndex[tokenId] = _ownedTokens[to].length;

        _ownedTokens[to].push(tokenId);
        
        // Bonus. Compile
    }

    //add tokens to the _alltokens array and set the position of the token index
    function _addTokenToAllTokenEnumeration(uint256 tokenId) private {
        _allTokenIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function tokenByIndex(uint256 _index) external view returns (uint256){
        //the index is not out of bound
        require(_index < totalSupply(), 'Global index is out of bound');
        return _allTokens[_index];
    }

    function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256){
        //The index is not out of bound
        require(_index < balanceOf(_owner), 'global index is out of bound');
        //address not 0
        //require(_owner != address(0));
        //_owner address is owned token(s)
        return _ownedTokens[_owner][_index];
    }

}