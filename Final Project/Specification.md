**Universal Upgradable Token Specification**
1. User account will be represented by the struct containing {Vault_Number, uint[NTYPE] containing token ID}  
2. Each type of token can be only purchased once by a single user until the previous one is burned.
3. All token are upgradable/downgradable using the following formula (current_level is abbreviated as CL): 
    *purchase level1= 100/(Number of tokens left)*(total supply of tokens)^2
    *upgrade_price=2^CL/(Number of tokens left+1)
    *downgrade_reward=2^CL/(Number of tokens left+1)*0.8
    *burning_reward= 2^(0.5*CL+CL^2)/(Number of tokens left+1)^CL*0.8^CL
    *mutating_price=upgrade_price/4
4. Prices are denominated in ERC20 token that is the native currency for the metaverse
5. For each address we should implement the stacking and unstaking of NFTs in the particular Vault
6. For each type of the token that is not 0 level, we should calculate and emit the following:
    *If upgradable (there are enough tokens), upgrade_price
    *If upgradable_max , upgrade_price_max (upgrade to max level)
    *downgrade_reward
    *burning_reward
    *if mutable, mutating_price
7.Leaderboard(optional): Identify who has the highest level for each particular token type, or the highest average level.

8. Interaction of different Games and players with ERC-20 Pool should follow the model proposed by Jean:
https://github.com/sushiswap/sushiswap/blob/canary/contracts/SushiBar.sol

9. So to be able to mint some reward for the players, Game should buy the ERC20 tokens by staking ETHER into the main contract, and then use obtained funds to remunerate players. Players could either buy the ERC20 tokens themselves, or play games for the ingame rewards that could be further exchanged for the ERC20 tokens.
