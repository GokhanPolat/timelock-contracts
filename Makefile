###############################################################################
#																																							#
# Makefile for foundry																												#
#																																							#
# License : MIT																																#
# Author  : Gokhan Polat																											#
# Date    : 2022/10/25																												#
#																																							#
# Description:																																#
# ------------																																#
# type "make" or "make help" to see commands																	#
#																																							#
###############################################################################


# ENV and DEFAULTS ############################################################
# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env
.DEFAULT_GOAL := help
.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'




###############################################################################
#                                  VARIABLES                                  #
###############################################################################
FORGE_TEST                  = forge test --match-path
IGNORE_FLYCHECK             = --no-match-contract=flycheck

SOLC_OPENZEPPELIN_REMAPPING = openzeppelin-contracts=lib/openzeppelin-contracts


# CONTRACTS ###################################################################
TIMELOCK_CONTRACT = ./src/compound/Timelock.sol
TIMELOCK_TESTS    = ./test/compound/TimelockTest.t.sol




###############################################################################
#                                  forge commands                             #
###############################################################################
install       :; forge install               ## Install project dependencies
update        :; forge update                ## Update project dependencies
build         :; forge build                 ## Build the project's smart contracts
trace-report  :; forge test -vv --gas-report ## Run tests with gas reporting
clean         :; forge clean                 ## Remove the build artifacts and cache directories
snapshot      :; forge snapshot              ## Create a snapshot of each test's gas usage
# fmt           :; forge fmt                  ### Formats Solidity source files
# test        :; forge test                   ### Run the project's tests
# trace       :; forge test -vv               ### Run the project's tests with verbose level 2
# trace-watch :; forge test -vv -watch        ### Run the project's tests with verbose level 2 and watch




###############################################################################
#                                   Timelock                                  #
###############################################################################

# TESTS #######################################################################
compound/timelock-test       :; ## Timelock test, for verbosity level type 'verbose=-vvvv'
	${FORGE_TEST} ${TIMELOCK_TESTS} $(verbose) --gas-report

compound/timelock-test-watch :; ## Timelock test and watch for verbosity level type 'verbose=-vvvv'
	${FORGE_TEST} ${TIMELOCK_TESTS} $(verbose) -watch
