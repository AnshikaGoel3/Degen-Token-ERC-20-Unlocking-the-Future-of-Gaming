// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

//contract named DegenGamingToken that inherits from ERC20 and Ownable
contract DegenGamingToken is ERC20, Ownable {
    mapping(address => uint256) public redeemedTokens;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {}

    // Function to mint new tokens, only the owner can mint
    function mintTokens(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Function to burn tokens, anyone can burn their own tokens
    function burnTokens(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Function to redeem tokens, burns the tokens from the user's balance
    function redeemTokens(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");
        _burn(msg.sender, amount);
        redeemedTokens[msg.sender] += amount;
    }

    // Function to check the balance of an account
    function checkBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }
}
