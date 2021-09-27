**Universal Upgradable Token Specification**

Modification comparing to the regular ERC-721 token:
1. Each token will have an additional mapping from Token_ID to Token_Type (enumerate) and Token_Level(enumerate) and Token_Vault(enumerate). We can use a mapping to the struct containing all those parameters for simplicity
2. Function Upgrade_Token(Token_Upgraded, Token_Sacrificed):
  will increase the level for the Token_Upgraded by 1 while burning Token_Sacrificed, both tokens should be locked within the same Token_Vault and be of the same Level and additional ERC20 fees could be deducted from the account. 
3. Function Mutate_Token (Token_Upgraded, Token_Sacrificed, Designated_Type):
  will modify the type of the Token_Upgraded to the Designated_Type at the expense of burning the Token_Sacrificed, both tokens should be within the same Token_Vault and Token_Sacrificed should be 1 Level below the Upgradable token and of any type.
4. Function Get_Balance(address, Token_Type, Token_Level, Token_Vault):
  will return the balance of the address of particular Token_Type if specified and Token_Level if specified and Token_Vault if specified.
5. Function Is_Upgradable(Token):
  will check if the conditions are met to perform and upgrade of the token
6. Function Is_Mutable(Token):
  will check if the conditions are met to perform and upgrade of the token
7. Function Token_Disassembly(Token):
  return the full price of the Token discounted for 20%, initial token is being burned
8. Function Stake(Token_ID, Vault_ID):
  locks the token within  one of the existing Vaults to update users game mechanics and interface
9. Function Unstake(Token_ID):
  unlocks the designated token
10. Optional:
  function update_max - updates particular type of the token to the maximum level possible using a single transaction



**Gameplay interaction:**
1. Wallet connect
2. Minting ERC20 reward based on the ingame rewards
3. Minting ERC721 using ERC20 tokens
4. Event listener for updating the state of the game in case of upgrade/mutate/unstake
5. UI for Vaults and Tokens(Upgrade, Mutate, Unstake)
