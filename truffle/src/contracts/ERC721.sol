// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721 {
    /*
    0. buiding out minting function
    a. NFT to point to an addtress
    b. keep track of the token IDs
    c. [DONE] MAPPING : keep track of token owners addresseds to token IDs
    d. [DONE] MAPPING : how many tokens each address has
    e. event the emits a transfer log - contract address, destination, ID
    */

    event Transfer( address indexed from, 
                    address indexed to, 
                    uint256 indexed tokenId);

    // Tracking Map of TokenIds and Token owners
    mapping(uint256 => address) private _tokenOwner;
    mapping(address => uint256) private _ownTokenCount;

    function _mint(address to, uint256 tokenId) internal virtual {
        // Prevent from Mint to address 0
        require(to != address(0), 'ERC721 minting to 0 address');
        // Token must never be minted
        require(!_exist(tokenId), 'ERC721 already minted');

        _tokenOwner[tokenId] = to;
        _ownTokenCount[to] += 1;

        emit Transfer(address(0), to, tokenId);

    }

    //return truthiness of the owner of tokenId is not zero
    function _exist(uint256 tokenId) internal view returns(bool){
        address owner = _tokenOwner[tokenId];
        return owner != address(0); 
    }

    function balanceOf(address _owner) public view returns (uint256){
        require(_owner != address(0), "ERC721: balance query for the zero address");
        return _ownTokenCount[_owner];
    }

    function ownerOf(uint256 _tokenId) external view returns (address){
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");
        return owner;

    }

}