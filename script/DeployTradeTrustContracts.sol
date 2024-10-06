// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/DocumentRegistry.sol";  // Adjust the path if necessary

contract DeployDocumentRegistry is Script {
    function run() external {
        vm.startBroadcast();
        
        // Deploy DocumentRegistry contract
        DocumentRegistry documentRegistry = new DocumentRegistry();
        console.log("DocumentRegistry deployed at:", address(documentRegistry));

        vm.stopBroadcast();
    }
}
