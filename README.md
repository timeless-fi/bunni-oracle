# BunniOracle

Gas-optimized oracle that uses a combination of Chainlink price oracles and Uniswap V3 built-in TWAP oracles to compute the value of a Bunni token / Uniswap V3 liquidity position without being vulnerable to flashloan manipulation attacks.

## Deployment address

BunniOracle is deployed to `0xEBe234F2A6ba1080f6620Ac340017a4cbB44c41F` on all of the following networks:

- Ethereum Mainnet
- Arbitrum Mainnet

## Usage guide

This guide will help you compute the USD value of Uniswap V3 liquidity positions and Bunni LP tokens using provided smart contract functions. Copy-paste code examples are given for quick implementation.

### Uniswap V3 Liquidity Positions

**1. Basic Query (Ethereum-only)**

For a simple, Ethereum-only query, use this function to compute the USD value of your Uniswap V3 position.

```solidity
uint256 usdValue = bunniOracle.quoteUSD(pool, tickLower, tickUpper, liquidity, uniV3OracleSecondsAgo, chainlinkPriceMaxAgeSecs);
```

**2. Gas-Saving (Ethereum-only)**

If you already know whether Chainlink feeds exist for your tokens, use this function. It saves around 5k gas.

```solidity
uint256 usdValue = bunniOracle.quoteUSD(pool, tickLower, tickUpper, liquidity, feed0Exists, feed1Exists, uniV3OracleSecondsAgo, chainlinkPriceMaxAgeSecs);
```

**3. Cross-Chain Support**

For non-Ethereum blockchains.

```solidity
uint256 usdValue = bunniOracle.quoteUSD(pool, tickLower, tickUpper, liquidity, uniV3OracleSecondsAgo, chainlinkPriceMaxAgeSecs, feed0, feed1);
```

**4. Gas-Efficient (Cross-Chain)**

The most gas-efficient function, but you must manually input token addresses and their decimal bases (`10**decimals`).

```solidity
uint256 usdValue = bunniOracle.quoteUSD(pool, token0, token1, token0Base, token1Base, tickLower, tickUpper, liquidity, uniV3OracleSecondsAgo, chainlinkPriceMaxAgeSecs, feed0, feed1);
```

### Bunni LP Tokens

**1. Basic Query (Ethereum-only)**

For a simple, Ethereum-only query, use this function to compute the USD price of a Bunni LP token.

```solidity
uint256 priceUSD = bunniOracle.bunniTokenPriceUSD(bunniToken, uniV3OracleSecondsAgo, chainlinkPriceMaxAgeSecs);
```

**2. Gas-Saving (Ethereum-only)**

If you already know whether Chainlink feeds exist for the pool's tokens, use this function. It saves around 5k gas.

```solidity
uint256 priceUSD = bunniOracle.bunniTokenPriceUSD(bunniToken, feed0Exists, feed1Exists, uniV3OracleSecondsAgo, chainlinkPriceMaxAgeSecs);
```

**3. Cross-Chain Support**

For non-Ethereum blockchains.

```solidity
uint256 priceUSD = bunniOracle.bunniTokenPriceUSD(bunniToken, uniV3OracleSecondsAgo, chainlinkPriceMaxAgeSecs, feed0, feed1);
```

**4. Gas-Efficient (Cross-Chain)**

The most gas-efficient function, but you must manually input token addresses and their decimal bases (`10**decimals`).

```solidity
uint256 priceUSD = bunniOracle.bunniTokenPriceUSDD(bunniToken, pool, token0, token1, token0Base, token1Base, tickLower, tickUpper, uniV3OracleSecondsAgo, chainlinkPriceMaxAgeSecs, feed0, feed1);
```

### Function Parameters:

- `pool`: The Uniswap V3 pool contract address.
- `tickLower`, `tickUpper`: Lower and upper ticks of your liquidity position.
- `liquidity`: The liquidity amount in your position.
- `uniV3OracleSecondsAgo`: TWAP window size for Uniswap V3 oracle, in seconds.
- `chainlinkPriceMaxAgeSecs`: Max age of Chainlink price data, in seconds.
- `feed0`, `feed1`: Chainlink price feed addresses for the respective tokens.

Plug in these parameters appropriately. Note that calls revert if Chainlink price data is too old or if TWAP window is too large for available data. 

Now, you're ready to compute USD values.

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
