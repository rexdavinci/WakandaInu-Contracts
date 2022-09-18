-include .env

  export FOUNDRY_ETH_RPC_URL=${BSC_TESTNET_URL}
#  export FOUNDRY_ETHERSCAN_API_KEY=${ETHERSCAN_KEY}
#  export PRIVATE_KEY=${PKEY}

# update-submodules: 
# 	@echo Update git submodules
# 	@git submodule update --init --recursive

# test-foundry-diamond: 
# 	@echo Run diamond tests
# 	@forge test -vvvvv

# deploy-testnet:
# 	@echo Deploying to Testnet
# 	@forge script script/Staking.s.sol:StakeDeployment --rpc-url FOUNDRY_ETH_RPC_URL --private-key 0x --broadcast --verify --etherscan-api-key ABCDEFGHIJK -vvvvv

 deploy-pool:
	@echo Deploying to Mainnet
	@forge script script/WKDStake.s.sol:WKDStake --rpc-url FOUNDRY_ETH_RPC_URL --private-key 0x --broadcast --verify --etherscan-api-key ABCDEFGHIJK  -vvvvv

test-pool:
	@echo Running test for token staking
	@forge test --mc WKDPoolTest -vvvvv 

test-gen:
	@echo Running test for generic staking
	@forge test --mc GStakingTest -vvvvv

	