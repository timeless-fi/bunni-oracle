# BunniOracle

Gas-optimized oracle that uses a combination of Chainlink price oracles and Uniswap V3 built-in TWAP oracles to compute the value of a Bunni token / Uniswap V3 liquidity position without being vulnerable to flashloan manipulation attacks.

## Deployment address

- Ethereum: [0xe50d791486956C6Ae8E75D7EF16030eD086d31BF](https://etherscan.io/address/0xe50d791486956C6Ae8E75D7EF16030eD086d31BF)

## Installation

To install with [Foundry](https://github.com/gakonst/foundry):

```
forge install timeless-fi/bunni-oracle
```

## Local development

This project uses [Foundry](https://github.com/gakonst/foundry) as the development framework.

### Dependencies

```
forge install
```

### Compilation

```
forge build
```

### Testing

```
forge test -f mainnet -vvv
```

### Contract deployment

Please create a `.env` file before deployment. An example can be found in `.env.example`.

#### Dryrun

```
forge script script/Deploy.s.sol -f [network]
```

### Live

```
forge script script/Deploy.s.sol -f [network] --verify --broadcast
```
