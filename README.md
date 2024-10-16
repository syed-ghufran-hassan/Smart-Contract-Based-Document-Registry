# Smart-Contract-Based-Document-Registry

The Decentralized Document Registry is a blockchain-based system that enables secure issuance, transfer, revocation, and verification of documents, ensuring authenticity and transparency through smart contracts.

## Key Features:

Document Issuance: Users can mint documents by uploading a unique hash of the document content. Each document is associated with an owner's address and is recorded on the blockchain to ensure tamper-proof storage.

Document Transfer: Ownership of documents can be securely transferred to new owners while ensuring that all transactions are authenticated and authorized, thereby maintaining a clear chain of custody.

Document Revocation: Users can revoke documents as needed, marking them as invalid on the blockchain to prevent misuse.

Document Verification: The system allows for easy verification of documents by checking their status on the blockchain. Users can confirm the authenticity and ownership of a document using its unique hash.

## Significance:

In industries where documentation is critical, such as shipping, finance, and legal sectors, this decentralized registry provides a reliable alternative to traditional document management systems. It minimizes the reliance on intermediaries, enhances security, and improves efficiency in document handling processes.

The Decentralized Document Registry is a step towards creating a more secure and efficient ecosystem for managing important documents, paving the way for future innovations in document verification and certification.

Please do include your API key in index.html on the placeholder

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
