// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol"; // Foundry's testing framework
import "../src/DocumentRegistry.sol"; // Import the contract to test

contract DocumentRegistryTest is Test {
    DocumentRegistry public documentRegistry;
    
    address user1 = address(0x123);
    address user2 = address(0x456);
    string documentHash = "document_hash_123"; // Mock hash for the document

    function setUp() public {
        // Deploy a new instance of the DocumentRegistry contract before each test
        documentRegistry = new DocumentRegistry();
    }

    function testIssueDocument() public {
        // Call the issueDocument function as user1
        vm.prank(user1);
        documentRegistry.issueDocument(documentHash);

        // Verify that the document was issued correctly
        (address owner, string memory hash, bool revoked) = documentRegistry.documents(documentHash);
        assertEq(owner, user1);
        assertEq(hash, documentHash);
        assertFalse(revoked);
    }

    function testFailIssueDocumentAlreadyExists() public {
        // Issue the document once
        vm.prank(user1);
        documentRegistry.issueDocument(documentHash);

        // Try to issue the same document again, which should fail
        vm.prank(user1);
        documentRegistry.issueDocument(documentHash); // This will revert
    }

    function testTransferDocument() public {
        // Issue a document by user1
        vm.prank(user1);
        documentRegistry.issueDocument(documentHash);

        // Transfer the document from user1 to user2
        vm.prank(user1);
        documentRegistry.transferDocument(documentHash, user2);

        // Verify that the document owner is now user2
        (address owner,,) = documentRegistry.documents(documentHash);
        assertEq(owner, user2);
    }

    function testFailTransferDocumentNotOwner() public {
        // Issue a document by user1
        vm.prank(user1);
        documentRegistry.issueDocument(documentHash);

        // Try to transfer the document by user2 (not the owner), which should fail
        vm.prank(user2);
        documentRegistry.transferDocument(documentHash, user2); // This will revert
    }

    function testRevokeDocument() public {
        // Issue a document by user1
        vm.prank(user1);
        documentRegistry.issueDocument(documentHash);

        // Revoke the document by user1
        vm.prank(user1);
        documentRegistry.revokeDocument(documentHash);

        // Verify that the document is revoked
        (, , bool revoked) = documentRegistry.documents(documentHash);
        assertTrue(revoked);
    }

    function testFailRevokeDocumentNotOwner() public {
        // Issue a document by user1
        vm.prank(user1);
        documentRegistry.issueDocument(documentHash);

        // Try to revoke the document by user2 (not the owner), which should fail
        vm.prank(user2);
        documentRegistry.revokeDocument(documentHash); // This will revert
    }

    function testVerifyDocument() public {
        // Issue a document by user1
        vm.prank(user1);
        documentRegistry.issueDocument(documentHash);

        // Verify that the document is valid
        bool isValid = documentRegistry.verifyDocument(documentHash);
        assertTrue(isValid);

        // Revoke the document
        vm.prank(user1);
        documentRegistry.revokeDocument(documentHash);

        // Verify that the document is no longer valid
        isValid = documentRegistry.verifyDocument(documentHash);
        assertFalse(isValid);
    }
}
