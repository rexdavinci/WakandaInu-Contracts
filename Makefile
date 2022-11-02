-include .env

#export FOUNDRY_ETH_RPC_URL=${BSC_TESTNET_URL}
#  export FOUNDRY_ETHERSCAN_API_KEY=${ETHERSCAN_KEY}
#  export PRIVATE_KEY=${PKEY}


 update-submodules: 
	@echo Update git submodules
	@git submodule update --init --recursive


 deploy-testnet:
	@echo Deploying to Testnet
	@forge script script/Staking.s.sol:StakeDeployment --rpc-url FOUNDRY_ETH_RPC_URL --private-key  --broadcast --verify --etherscan-api-key  -vvvvv

 deploy-swap:
	@echo Deploying Swap Contracts to mainnet
	@forge script script/Staking.s.sol:StakeDeployment --rpc-url <> --private-key <> --broadcast --verify --etherscan-api-key <> -vvvvv

 deploy-pool:
	@echo Deploying to Mainnet
	@forge script script/WKDStake.s.sol:WKDStake --rpc-url FOUNDRY_ETH_RPC_URL --private-key  --broadcast --verify --etherscan-api-key   -vvvvv

deploy-generalPool:
	@echo Deploying GeneralPool to Mainnet
	@forge script script/WKDGeneralPool.s.sol:WKDGeneralPool --rpc-url FOUNDRY_ETH_RPC_URL --private-key  --broadcast --verify --etherscan-api-key   -vvvvv
test-pool:
	@echo Running test for token staking
	@forge test --mc WKDPoolTest -vvvvv 


	