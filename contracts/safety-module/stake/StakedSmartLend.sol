// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.7.5;
pragma experimental ABIEncoderV2;

import {IERC20} from "../interfaces/IERC20.sol";
import {StakedToken} from "./StakedToken.sol";

/**
 * @title StakedSmartLend
 * @notice StakedToken with SMARTLEND token as staked token
 * @author SmartLend
 **/
contract StakedSmartLend is StakedToken {
    string internal constant NAME = "Staked SmartLend";
    string internal constant SYMBOL = "stkSMARTLEND";
    uint8 internal constant DECIMALS = 18;

    constructor(
        IERC20 stakedToken,
        IERC20 rewardToken,
        uint256 cooldownSeconds,
        uint256 unstakeWindow,
        address rewardsVault,
        address emissionManager,
        uint128 distributionDuration
    )
        public
        StakedToken(
            stakedToken,
            rewardToken,
            cooldownSeconds,
            unstakeWindow,
            rewardsVault,
            emissionManager,
            distributionDuration,
            NAME,
            SYMBOL,
            DECIMALS
        )
    {}
}
