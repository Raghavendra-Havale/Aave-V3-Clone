// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.7.5;

import {IStakedSmartLendImplWithInitialize} from "../interfaces/IStakedSmartLendImplWithInitialize.sol";
import {IEIP2612Token} from "../interfaces/IEIP2612Token.sol";

/**
 * @title StakingHelper contract
 * @author SmartLend
 * @dev implements a staking function that allows staking through the EIP2612 capabilities of the SmartLend token
 **/

contract SmartLendStakingHelper {
    IStakedSmartLendImplWithInitialize public immutable STAKE;
    IEIP2612Token public immutable SmartLend;

    constructor(address stake, address smartlend) public {
        STAKE = IStakedSmartLendImplWithInitialize(stake);
        SmartLend = IEIP2612Token(smartlend);
        //approves the stake to transfer uint256.max tokens from this contract
        //avoids approvals on every stake action
        IEIP2612Token(smartlend).approve(address(stake), type(uint256).max);
    }

    /**
     * @dev stakes on behalf of msg.sender using signed approval.
     * The function expects a valid signed message from the user, and executes a permit()
     * to approve the transfer. The helper then stakes on behalf of the user
     * @param user the user for which the staking is being executed
     * @param amount the amount to stake
     * @param v signature param
     * @param r signature param
     * @param s signature param
     **/
    function stake(
        address user,
        uint256 amount,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external {
        SmartLend.permit(
            user,
            address(this),
            amount,
            type(uint256).max,
            v,
            r,
            s
        );
        SmartLend.transferFrom(user, address(this), amount);
        STAKE.stake(user, amount);
    }
}
