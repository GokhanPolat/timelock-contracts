// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/src/Test.sol";
import {console2} from "forge-std/src/console2.sol";
import {console} from "forge-std/src/console.sol";

// Custom test utils, createUser, mineBlocks etc.
import {Utils} from "../utils/Utils.sol";

import {Timelock} from "src/compound/Timelock.sol";
import {MockERC20} from "src/mock/MockERC20.sol";

// solhint-disable func-name-mixedcase, max-states-count
contract TimelockTest is Test {
  Utils private utils = new Utils();

  // VM USER / PERSONAS /////////////////////////////////////////////////////
  address payable[] private users;
  address private timelockDeployer;
  address private mockERC20Deployer;
  address private mockHolder;

  // CONTRACTS ////////////////////////////////////////////////////////////////
  Timelock private timelock;
  MockERC20 private mockErc20;

  // VARIABLES ////////////////////////////////////////////////////////////////
  string private tokenName = "MockERC20";
  string private tokenSymbol = "mERC20";
  uint256 private mintValue = 1000 ether;
  uint256 private transferValue = 1 ether;

  address private target;
  uint256 private value = 1e15; // msg.value 0.001 ether
  string private signature = "mint(address,uint256)";
  bytes private data;

  // solhint-disable-next-line not-rely-on-time
  uint256 private eta = block.timestamp + 3 days;

  // Initialize ///////////////////////////////////////////////////////////////
  function setUp() public {
    users = utils.createUsers(5);

    timelockDeployer = users[0];
    mockERC20Deployer = users[1];
    mockHolder = users[2];

    vm.label(timelockDeployer, "timelockDeployer");
    vm.label(mockERC20Deployer, "mockERC20Deployer");
    vm.label(mockHolder, "mockHolder");

    // Timelock ///////////////////////////////////////////////////////////////
    vm.prank(timelockDeployer);
    timelock = new Timelock(timelockDeployer, 3 days);

    // MockERC20 //////////////////////////////////////////////////////////////
    vm.prank(mockERC20Deployer);
    mockErc20 = new MockERC20(tokenName, tokenSymbol, address(timelock));

    // Timelock target variables //////////////////////////////////////////////
    target = address(mockErc20);
    signature = "mint(address,uint256)";
    data = abi.encode(address(mockHolder), mintValue);
  }

  /////////////////////////////////////////////////////////////////////////////
  //                                  TESTS                                  //
  /////////////////////////////////////////////////////////////////////////////

  function test_01_PrintAccounts() public {
    console2.log("--------------------- ACCOUNTS ------------------------");
    console2.log("timelockDeployer  : ", timelockDeployer);
    console2.log("mockERC20Deployer : ", mockERC20Deployer);
    console2.log("mockHolder        : ", mockHolder);

    console2.log("-------------------- CONTRACTS ------------------------");
    console2.log("mockErc20         : ", address(mockErc20));
    console2.log("timelock          : ", address(timelock));
    console2.log("-------------------------------------------------------");

    assertTrue(true);
  }

  function test_02_QueueTransaction() public {
    // prank timelockDeployer /////////////////////////////////////////////////
    vm.prank(timelockDeployer);
    timelock.queueTransaction(target, value, signature, data, eta);

    assertTrue(true);
  }

  function test_03_ExecuteTransaction() public {
    // prank timelockDeployer /////////////////////////////////////////////////
    vm.startPrank(timelockDeployer);
    payable(address(timelock)).transfer(transferValue);

    timelock.queueTransaction(target, value, signature, data, eta);

    vm.warp(5 days);

    timelock.executeTransaction(target, value, signature, data, eta);
    vm.stopPrank();

    uint256 holderBalance = mockErc20.balanceOf(mockHolder);
    uint256 totalSupply = mockErc20.totalSupply();

    assertEq(holderBalance, mintValue);
    assertEq(totalSupply, mintValue);

    console2.log("----------------------------------------------------------");
    console2.log("holderBalance         : ", holderBalance);
    console2.log("mockErc20 totalSupply : ", totalSupply);
    console2.log("----------------------------------------------------------");
    console2.log("timelock Balance      : ", address(timelock).balance);
    console2.log("mockErc20 Balance     : ", address(mockErc20).balance);

    assertEq(address(timelock).balance, transferValue - value);
    assertEq(address(mockErc20).balance, value);
  }
}
