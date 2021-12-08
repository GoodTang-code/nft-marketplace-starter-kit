// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC721Metadata {
    function name() external view returns (string memory _name);
    function symbol() external view returns (string memory _symbol);

    ///  3986. The URI may point to a JSON file that conforms to the "ERC721
    ///  Metadata JSON Schema".
    //function tokenURI(uint256 _tokenId) external view returns (string memory);
}