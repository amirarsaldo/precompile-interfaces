pragma solidity ^0.8.0;

/** @dev The contract's address. */
address constant KEY_MANAGER_ADDRESS = 0x0000000000000000000000000000000000000802;

/** @dev The contract's instance. */
KeyManager constant KEY_MANAGER_CONTRACT = KeyManager(KEY_MANAGER_ADDRESS);

interface KeyManager {

    enum KeyType {
        BABE,
        GRANDPA,
        ImOnline
    }

    /**
    * @notice Sets the session keys of the function caller to keys. Allows an account to set its session key prior to becoming a validator. This doesn’t take effect until the next session.
    * @param keys The output from an 'author_rotateKeys' RPC call
    */
    function setKeys(bytes calldata keys) external;

    /**
    * @notice Removes any session keys of the function caller. This doesn’t take effect until the next session.
    */
    function purgeKeys() external;

    /**
    * @notice Query the owner of a session key by returning the owner’s address.
    * @param keyType The type of key provided
    * @param key The key data
    * @return The address of the key owner, or the zero address if no owner is found
    */
    function keyOwner(KeyType keyType, bytes32 key) external view returns (address);

    /**
    * @dev Populates the precompile address with dummy bytecode, allowing the precompile to pass related checks.
    * For example, the presence of bytecode allows wallets like Metamask to recognize the precompile as a contract.
    */
    function populateBytecode() external;
}
