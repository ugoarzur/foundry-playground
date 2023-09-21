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

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
