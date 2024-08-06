// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BeatBitNFT is ERC721URIStorage, Ownable {
    uint256 private tokenCounter;

    constructor(address initialOwner) ERC721("BeatBitNFT", "BBNFT") Ownable(initialOwner) {
        tokenCounter = 0; // Initialize the tokenCounter
    }

    function createNFT(string memory tokenURI) public onlyOwner returns (uint256) {
        uint256 newItemId = tokenCounter;
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        tokenCounter++;
        return newItemId;
    }
}
