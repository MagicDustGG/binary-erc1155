// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

/**
 * @dev Implementation of a binary multi-token.
 * See https://eips.ethereum.org/EIPS/eip-1155
 * Originally based on code by OpenZeppelin: https://github.com/OpenZeppelin/openzeppelin-contracts
 *
 * This implementation lets addresses hold a unique instance of multiple tokens,
 * but they cannot have more than one token id
 */
contract BinaryERC1155 is ERC1155 {
    // Mapping from accounts to packed token ids
    mapping(address => uint256) internal _balances;

    // solhint-disable no-empty-blocks
    constructor(string memory uri_) ERC1155(uri_) {}

    /// @notice Gives the balance of the specified token ID for the specified account
    /// @param account_ the account to check the balance for
    /// @param id_ the token ID to check the balance of. Must be less than 256
    /// @return the balance of the token ID for the specified account
    function balanceOf(address account_, uint256 id_) public view virtual override returns (uint256) {
        require(account_ != address(0), "ERC1155: balance query for the zero address");
        require(id_ < 256, "ERC1155: balance query for invalid token id");

        uint256 packedBalance = _balances[account_];

        return (packedBalance / 2**id_) % 2;
    }
}