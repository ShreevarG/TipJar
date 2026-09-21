// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//importing Foundry's Script functionality for deploying contracts
import {Script} from "forge-std/Script.sol";
//importing TipJar contract that we want to deploy
import {TipJar} from "../src/TipJar.sol";

contract DeployTipJar is Script {
    //function to run the deployment process
    function run() external returns (TipJar tipJar) {
        //sending the transactions created to the blockchain
        vm.startBroadcast();

        //deploying a new TipJar contract (finally)
        tipJar = new TipJar();

        //stopping the transactions to the blockchain
        vm.stopBroadcast();
    }
}