# UniV3LpOracle

Uniswap V3 liquidity position price oracle that wses a combination of Chainlink price oracles and Uniswap V3 built-in TWAP oracles to compute the value of a Uniswap V3 liquidity position without being vulnerable to flashloan manipulation attacks.

## Installation

To install with [Foundry](https://github.com/gakonst/foundry):

```
forge install timeless-fi/univ3-lp-oracle
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
forge test -f mainnet
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