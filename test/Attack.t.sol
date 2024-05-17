// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import {Test, console} from "forge-std/Test.sol";
import {Good} from "../src/Good.sol";
import {Attack} from "../src/Attack.sol";
import {Helper} from "../src/Helper.sol";

contract DelegateCallAttack is Test {
    //variables for instances of our contracts
    Good public goodContract;
    Helper public helperContract;
    Attack public attackContract;

    function setUp() public {
        // Deploy the Helper Contract
        helperContract = new Helper();

        // Deploy the Good Contract
        goodContract = new Good(address(helperContract));

        // Deploy the Attack Contract
        attackContract = new Attack(goodContract);
    }

    function testAttack() public {
        // Let's attack the Good Contract
        attackContract.attack();

        assertEq(goodContract.owner(), address(attackContract));
    }
}
