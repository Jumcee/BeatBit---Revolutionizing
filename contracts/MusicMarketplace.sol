// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";

contract MusicMarketplace {
    struct Listing {
        address seller;
        uint256 price;
    }

    mapping(address => mapping(uint256 => Listing)) public listings;

    function listItem(address nftContract, uint256 tokenId, uint256 price) public {
        IERC721(nftContract).transferFrom(msg.sender, address(this), tokenId);
        listings[nftContract][tokenId] = Listing(msg.sender, price);
    }

    function buyItem(address nftContract, uint256 tokenId) public payable {
        Listing storage listing = listings[nftContract][tokenId];
        require(msg.value == listing.price, "Incorrect price");

        IERC721(nftContract).transferFrom(address(this), msg.sender, tokenId);
        payable(listing.seller).transfer(msg.value);

        delete listings[nftContract][tokenId];
    }

    function getListing(address nftContract, uint256 tokenId) public view returns (Listing memory) {
        return listings[nftContract][tokenId];
    }
}
