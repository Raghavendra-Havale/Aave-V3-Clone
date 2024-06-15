// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {ISmartLendIncentivesController} from "../../interfaces/ISmartLendIncentivesController.sol";

contract MockIncentivesController is ISmartLendIncentivesController {
    function handleAction(address, uint256, uint256) external override {}
}
