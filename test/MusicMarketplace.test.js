const MusicMarketplace = artifacts.require("MusicMarketplace");
const YourNFT = artifacts.require("YourNFT"); // Replace with your NFT contract

contract("MusicMarketplace", accounts => {
  let marketplace, nftContract;
  let account1, account2;
  let tokenId;

  beforeEach(async () => {
    marketplace = await MusicMarketplace.deployed();
    nftContract = await YourNFT.deployed();

    account1 = accounts[0];
    account2 = accounts[1];

    // Mint an NFT for testing
    await nftContract.mint(account1, 1, { from: account1 });
    tokenId = 1;
  });

  it("should list an item", async () => {
    const price = web3.utils.toWei("1", "ether");
    await nftContract.approve(marketplace.address, tokenId, { from: account1 });
    await marketplace.listItem(nftContract.address, tokenId, price, { from: account1 });

    const listing = await marketplace.getListing(nftContract.address, tokenId);
    assert.equal(listing.seller, account1);
    assert.equal(listing.price, price);
  });

  it("should buy an item", async () => {
    const price = web3.utils.toWei("1", "ether");
    await nftContract.approve(marketplace.address, tokenId, { from: account1 });
    await marketplace.listItem(nftContract.address, tokenId, price, { from: account1 });

    await marketplace.buyItem(nftContract.address, tokenId, { from: account2, value: price });

    const owner = await nftContract.ownerOf(tokenId);
    assert.equal(owner, account2);

    const listing = await marketplace.getListing(nftContract.address, tokenId);
    assert.equal(listing.seller, address(0));
    assert.equal(listing.price, 0);
  });

  // Add more tests for different scenarios (e.g., insufficient funds, invalid token ID, etc.)
});