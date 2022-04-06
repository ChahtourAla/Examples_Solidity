// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Ownable {
    address owner; 

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "must be owner");
        _;
    }
}

contract SecretVault {
    string secret;

    constructor(string memory _secret) {
        secret = _secret;
    }

    function getSecret() public view returns (string memory) {//can be called by anyone
        return secret;
    }
}

contract MyContract is Ownable {
    address secretVault;

    constructor(string memory _secret) {
        SecretVault _secretVault = new SecretVault(_secret);
        secretVault = address(_secretVault);
        super;
    }

    function getSecret() public view onlyOwner returns (string memory) {//can be called by anyone
        SecretVault _secretVault = SecretVault(secretVault);
        return _secretVault.getSecret();
    }
}