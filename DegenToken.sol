// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

//contract named DegenGamingToken that inherits from ERC20 and Ownable
contract DegenGamingToken is ERC20, Ownable {
    //Struct to represent an in-game item with a name, cost and existence flag
    struct Item {
        string name;
        uint256 cost;
        bool exists;
    }

    //mapping to store items by their name
    mapping(string => Item) public items;

    //mapping to track the total number of tokens redeemed by each user
    mapping(address => uint256) public redeemedTokens;

    //constructor to initialize the token name and symbol, and to set up the initial items 
    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        items["Sword"] = Item ({
            name: "Sword",
            cost: 100,
            exists: true
        });

        items["Shield"] = Item ({
            name: "Shield",
            cost: 150,
            exists: true
        });

        items["potion"] = Item ({
            name: "potion",
            cost: 50,
            exists: true
        });

        items["Armor"] = Item ({
            name: "Armor",
            cost: 200,
            exists: true
        });
    }

    // Function to mint new tokens, only the owner can mint
    function mintTokens(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Function to burn tokens, anyone can burn their own tokens
    function burnTokens(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Function to redeem tokens for an in-game item, burns the corresponding amount of tokens from the user's balance
    function redeemTokens(string memory itemName) public {
        Item memory item = items[itemName];
        require(item.exists, "Item does not exist");
        require(balanceOf(msg.sender) >= item.cost, "Insufficient balance");

        _burn(msg.sender, item.cost);
        redeemedTokens[msg.sender] += item.cost;
    }

    // Function to check the balance of an account
    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }
}
