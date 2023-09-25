## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

| command                                             | description                                                 |
| --------------------------------------------------- | ----------------------------------------------------------- |
| `$ forge build`                                     | Build the smart contracts                                   |
| `$ forge test`                                      | Testing the smart contracts                                 |
| `$ forge test --match-path test/Wallet.t.sol -vvvv` | Testing a specific file in verbose mode                     |
| `$ forge fmt`                                       | Formatting smart contracts and tests                        |
| `$ forge snapshot`                                  | Take a snapshot of the gas costs for all the functions      |
| `$ anvil`                                           | Launch a local Ethereum Node                                |
| `$ cast <subcommand>`                               | Use it to interact onchain with deployed EVM smart contract |

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

# Tests

- [x] Installing Foundry
- [x] Write basic tests
- [x] Set Solidity compiler version (toml)
- [x] Remapping dependencies & libs
- [x] formats code & console.log
- [x] Authentication
- [x] Error handling
- [x] Event handling
- [x] Time handling (`block.timestamp` in seconds, even in days)
- [x] Sending ETH
- [x] Transaction Signature
- [x] Gas-less token Transfer (with ERC20Permit.sol)
- [ ] Forking networks
- [ ] Minting a Million DAI ERC20 on Mainnet Fork
- [ ] Invariant testings
- [ ] FFI
- [ ] Differential test
- [ ] Vyper Smart Contract?
- [ ] Deploy with Foundry script

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

### Resources

- [Foundry Playlist](https://youtu.be/YJN7MMllK8M?feature=shared)
