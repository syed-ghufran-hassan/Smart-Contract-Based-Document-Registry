// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title DocumentRegistry - A contract to issue, transfer, revoke, and verify documents.
contract DocumentRegistry {
    
    /// @notice Struct to represent a document with its owner, hash, and revocation status.
    struct Document {
        address owner;          // Owner of the document (who issued it)
        string documentHash;    // Unique hash representing the document
        bool revoked;           // Boolean flag to indicate if the document is revoked
    }

    /// @notice A mapping of document hashes to their corresponding Document details.
    /// @dev The key is the document's hash and the value is the Document struct.
    mapping(string => Document) public documents;

    /// @notice Event emitted when a document is issued.
    /// @param documentHash The unique hash of the issued document.
    /// @param owner The address of the document's owner (issuer).
    event DocumentIssued(string indexed documentHash, address indexed owner);

    /// @notice Event emitted when a document is transferred to a new owner.
    /// @param documentHash The unique hash of the transferred document.
    /// @param newOwner The address of the new owner.
    event DocumentTransferred(string indexed documentHash, address indexed newOwner);

    /// @notice Event emitted when a document is revoked.
    /// @param documentHash The unique hash of the revoked document.
    event DocumentRevoked(string indexed documentHash);

    /// @notice Function to issue a new document by associating its hash with the sender's address.
    /// @dev Ensures the document is not already issued by checking the owner of the document hash.
    /// @param _documentHash The unique hash of the document to be issued.
    function issueDocument(string memory _documentHash) external {
        require(documents[_documentHash].owner == address(0), "Document already issued");
        documents[_documentHash] = Document(msg.sender, _documentHash, false); // Create new document
        emit DocumentIssued(_documentHash, msg.sender); // Emit event on successful issuance
    }

    /// @notice Function to transfer ownership of a document to a new address.
    /// @dev Can only be called by the current owner and the document must not be revoked.
    /// @param _documentHash The unique hash of the document to transfer.
    /// @param _newOwner The address of the new owner of the document.
    function transferDocument(string memory _documentHash, address _newOwner) external {
        require(documents[_documentHash].owner == msg.sender, "Not the document owner"); // Ensure caller is the owner
        require(!documents[_documentHash].revoked, "Document is revoked"); // Ensure document is not revoked
        documents[_documentHash].owner = _newOwner; // Transfer ownership
        emit DocumentTransferred(_documentHash, _newOwner); // Emit event on successful transfer
    }

    /// @notice Function to revoke a document.
    /// @dev Can only be called by the current owner of the document.
    /// @param _documentHash The unique hash of the document to revoke.
    function revokeDocument(string memory _documentHash) external {
        require(documents[_documentHash].owner == msg.sender, "Not the document owner"); // Ensure caller is the owner
        documents[_documentHash].revoked = true; // Mark the document as revoked
        emit DocumentRevoked(_documentHash); // Emit event on successful revocation
    }

    /// @notice Function to verify if a document is valid (exists and is not revoked).
    /// @param _documentHash The unique hash of the document to verify.
    /// @return Returns true if the document is valid (not revoked and exists), false otherwise.
    function verifyDocument(string memory _documentHash) external view returns (bool) {
        return (documents[_documentHash].owner != address(0) && !documents[_documentHash].revoked); // Check existence and revocation status
    }
}
