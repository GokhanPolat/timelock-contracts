This repo contains various DAO contracts especially Timelock ones. Some contracts conflicts with compiler version, for this reason I may or may not have changed that contracts behaviors.

> As we always say DYOR.

- [Compound Protocol](https://github.com/compound-finance/compound-protocol/blob/master/contracts/Timelock.sol "https://github.com/compound-finance/compound-protocol/blob/master/contracts/Timelock.sol")
- [Youtube - Time Lock | Solidity 0.8](https://www.youtube.com/watch?v=P1f2a5Ckjpg "https://www.youtube.com/watch?v=P1f2a5Ckjpg")
- [Bypassing Smart Contract Timelocks](https://blog.openzeppelin.com/bypassing-smart-contract-timelocks/ "https://blog.openzeppelin.com/bypassing-smart-contract-timelocks/")
- [What is a Timelock?](https://www.certik.com/resources/blog/Timelock "https://www.certik.com/resources/blog/Timelock")
- [Binance Hashed TimeLock Contract (HTLC)](https://academy.binance.com/en/glossary/hashed-timelock-contract "https://academy.binance.com/en/glossary/hashed-timelock-contract")
- [What Are Hashed Timelock Contracts (HTLCs)?](https://hackernoon.com/what-are-hashed-timelock-contracts-htlcs-application-in-lightning-network-payment-channels-14437eeb9345 "https://hackernoon.com/what-are-hashed-timelock-contracts-htlcs-application-in-lightning-network-payment-channels-14437eeb9345")
- [hashed-timelock-contract-ethereum](https://github.com/chatch/hashed-timelock-contract-ethereum "https://github.com/chatch/hashed-timelock-contract-ethereum")
- [OpenZeppelin - Timelock](https://docs.openzeppelin.com/contracts/4.x/api/governance#timelock "https://docs.openzeppelin.com/contracts/4.x/api/governance#timelock")

## Payment Channeling

- [Channeling Contracts](https://rusty.ozlabs.org/?p=467 "https://rusty.ozlabs.org/?p=467")
- [The Bitcoin Lightning Network](http://lightning.network/lightning-network-paper-DRAFT-0.5.pdf "http://lightning.network/lightning-network-paper-DRAFT-0.5.pdf")

# Run Project

## Installation

```shell
make install
```

## Update

```shell
make update
```

## Build

```shell
make build
```

## Test

For example:
Compound's Timelock Contract

```shell
make compound/timelock-test
```

## Getting Help

```shell
make # or make help
```

# Disclaimer

This repository does not constitute legal or investment advice. The preparers of this repository present it as an informational exercise documenting the due diligence involved in the secure development of the target contract only, and make no material claims or guarantees concerning the contract's operation post-deployment. The preparers of this repository assume no liability for any and all potential consequences of the deployment or use of this contract.

Importantly, the presented formal specification considers only the behaviors within the EVM, without considering the block/transaction level properties or off-chain behaviors, meaning that the verification result does not completely rule out the possibility of the contract being vulnerable to existing and/or unknown attacks.

Smart contracts are still a nascent software arena, and their deployment and public offering carries substantial risk. This repository makes no claims that its analysis is fully comprehensive, and recommends always seeking multiple opinions and audits.

This repository is also not comprehensive in scope, excluding a number of components critical to the correct operation of this system.

The possibility of human error in the manual review process is very real, and we recommend seeking multiple independent opinions on any claims which impact a large quantity of funds.
