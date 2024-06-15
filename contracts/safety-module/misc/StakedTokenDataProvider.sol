// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;
pragma experimental ABIEncoderV2;

import {IERC20} from "../interfaces/IERC20.sol";
import {AggregatedStakedSmartLendV3} from "../interfaces/AggregatedStakedSmartLendV3.sol";
import {IStakedToken} from "../interfaces/IStakedToken.sol";
import {AggregatorInterface} from "../interfaces/AggregatorInterface.sol";
import {IStakedTokenDataProvider} from "../interfaces/IStakedTokenDataProvider.sol";

/**
 * @title StakedTokenDataProvider
 * @notice Data provider contract for Staked Tokens of the Safety Module (e.g. SMARTLEND:StkSMARTLEND and BPT:StkBPT)
 */
contract StakedTokenDataProvider is IStakedTokenDataProvider {
    /// @inheritdoc IStakedTokenDataProvider
    address public immutable override ETH_USD_PRICE_FEED;

    /// @inheritdoc IStakedTokenDataProvider
    address public immutable override SMARTLEND_PRICE_FEED;

    /// @inheritdoc IStakedTokenDataProvider
    address public immutable override BPT_PRICE_FEED;

    /// @inheritdoc IStakedTokenDataProvider
    address public immutable override SMARTLEND;

    /// @inheritdoc IStakedTokenDataProvider
    address public immutable override STAKED_SMARTLEND;

    /// @inheritdoc IStakedTokenDataProvider
    address public immutable override BPT;

    /// @inheritdoc IStakedTokenDataProvider
    address public immutable override STAKED_BPT;

    uint256 private constant SECONDS_PER_YEAR = 365 days;

    uint256 private constant APY_PRECISION = 10000;

    /**
     * @dev Constructor
     * @param smartlend The address of the SMARTLEND token
     * @param stkSmartLend The address of the StkSMARTLEND token
     * @param bpt The address of the BPT SMARTLEND / ETH token
     * @param stkBpt The address of the StkBptSMARTLEND token
     * @param ethUsdPriceFeed The address of ETH price feed (USD denominated, with 8 decimals)
     * @param smartlendPriceFeed The address of SMARTLEND price feed (ETH denominated, with 18 decimals)
     * @param bptPriceFeed The address of StakedBpt price feed (ETH denominated, with 18 decimals)
     */
    constructor(
        address smartlend,
        address stkSmartLend,
        address bpt,
        address stkBpt,
        address ethUsdPriceFeed,
        address smartlendPriceFeed,
        address bptPriceFeed
    ) public {
        SMARTLEND = smartlend;
        STAKED_SMARTLEND = stkSmartLend;
        BPT = bpt;
        STAKED_BPT = stkBpt;
        ETH_USD_PRICE_FEED = ethUsdPriceFeed;
        SMARTLEND_PRICE_FEED = smartlendPriceFeed;
        BPT_PRICE_FEED = bptPriceFeed;
    }

    /// @inheritdoc IStakedTokenDataProvider
    function getAllStakedTokenData()
        external
        view
        override
        returns (
            StakedTokenData memory stkSmartLendData,
            StakedTokenData memory stkBptData,
            uint256 ethPrice
        )
    {
        stkSmartLendData = _getStakedTokenData(
            AggregatedStakedSmartLendV3(STAKED_SMARTLEND)
        );
        stkBptData = _getStakedTokenData(
            AggregatedStakedSmartLendV3(STAKED_BPT)
        );
        ethPrice = uint256(
            AggregatorInterface(ETH_USD_PRICE_FEED).latestAnswer()
        );
    }

    /// @inheritdoc IStakedTokenDataProvider
    function getStkSmartLendData()
        external
        view
        override
        returns (StakedTokenData memory stkSmartLendData)
    {
        stkSmartLendData = _getStakedTokenData(
            AggregatedStakedSmartLendV3(STAKED_SMARTLEND)
        );
    }

    /// @inheritdoc IStakedTokenDataProvider
    function getStkBptData()
        external
        view
        override
        returns (StakedTokenData memory stkBptData)
    {
        stkBptData = _getStakedTokenData(
            AggregatedStakedSmartLendV3(STAKED_BPT)
        );
    }

    /// @inheritdoc IStakedTokenDataProvider
    function getAllStakedTokenUserData(
        address user
    )
        external
        view
        override
        returns (
            StakedTokenData memory stkSmartLendData,
            StakedTokenUserData memory stkSmartLendUserData,
            StakedTokenData memory stkBptData,
            StakedTokenUserData memory stkBptUserData,
            uint256 ethPrice
        )
    {
        stkSmartLendData = _getStakedTokenData(
            AggregatedStakedSmartLendV3(STAKED_SMARTLEND)
        );
        stkSmartLendUserData = _getStakedTokenUserData(
            AggregatedStakedSmartLendV3(STAKED_SMARTLEND),
            user
        );
        stkBptData = _getStakedTokenData(
            AggregatedStakedSmartLendV3(STAKED_BPT)
        );
        stkBptUserData = _getStakedTokenUserData(
            AggregatedStakedSmartLendV3(STAKED_BPT),
            user
        );
        ethPrice = uint256(
            AggregatorInterface(ETH_USD_PRICE_FEED).latestAnswer()
        );
    }

    /// @inheritdoc IStakedTokenDataProvider
    function getStkSmartLendUserData(
        address user
    )
        external
        view
        override
        returns (
            StakedTokenData memory stkSmartLendData,
            StakedTokenUserData memory stkSmartLendUserData
        )
    {
        stkSmartLendData = _getStakedTokenData(
            AggregatedStakedSmartLendV3(STAKED_SMARTLEND)
        );
        stkSmartLendUserData = _getStakedTokenUserData(
            AggregatedStakedSmartLendV3(STAKED_SMARTLEND),
            user
        );
    }

    /// @inheritdoc IStakedTokenDataProvider
    function getStkBptSmartLendUserData(
        address user
    )
        external
        view
        override
        returns (
            StakedTokenData memory stkBptData,
            StakedTokenUserData memory stkBptUserData
        )
    {
        stkBptData = _getStakedTokenData(
            AggregatedStakedSmartLendV3(STAKED_BPT)
        );
        stkBptUserData = _getStakedTokenUserData(
            AggregatedStakedSmartLendV3(STAKED_BPT),
            user
        );
    }

    /**
     * @notice Returns data of the Staked Token passed as parameter
     * @param stakedToken The address of the StakedToken (eg. stkSmartLend, stkBptSmartLend)
     * @return data An object with general data of the StakedToken
     */
    function _getStakedTokenData(
        AggregatedStakedSmartLendV3 stakedToken
    ) internal view returns (StakedTokenData memory data) {
        data.stakedTokenTotalSupply = stakedToken.totalSupply();
        data.stakedTokenTotalRedeemableAmount = stakedToken.previewRedeem(
            data.stakedTokenTotalSupply
        );
        data.stakeCooldownSeconds = stakedToken.COOLDOWN_SECONDS();
        data.stakeUnstakeWindow = stakedToken.UNSTAKE_WINDOW();
        data.rewardTokenPriceEth = uint256(
            AggregatorInterface(SMARTLEND_PRICE_FEED).latestAnswer()
        );
        data.distributionEnd = stakedToken.DISTRIBUTION_END();

        data.distributionPerSecond = block.timestamp < data.distributionEnd
            ? stakedToken.assets(address(stakedToken)).emissionPerSecond
            : 0;

        // stkSmartLend
        if (address(stakedToken) == STAKED_SMARTLEND) {
            data.stakedTokenPriceEth = data.rewardTokenPriceEth;
            // assumes SMARTLEND and stkSMARTLEND have the same value
            data.stakeApy = _calculateApy(
                data.distributionPerSecond,
                data.stakedTokenTotalSupply
            );

            // stkBptSmartLend
        } else if (address(stakedToken) == STAKED_BPT) {
            data.stakedTokenPriceEth = uint256(
                AggregatorInterface(BPT_PRICE_FEED).latestAnswer()
            );
            data.stakeApy = _calculateApy(
                data.distributionPerSecond * data.rewardTokenPriceEth,
                data.stakedTokenTotalSupply * data.stakedTokenPriceEth
            );
        }
    }

    /**
     * @notice Calculates the APY of the reward distribution among StakedToken holders
     * @dev It uses the value of the reward and StakedToken asset
     * @param distributionPerSecond The value of the rewards being distributed per second
     * @param stakedTokenTotalSupply The value of the total supply of StakedToken asset
     */
    function _calculateApy(
        uint256 distributionPerSecond,
        uint256 stakedTokenTotalSupply
    ) internal pure returns (uint256) {
        if (stakedTokenTotalSupply == 0) return 0;
        return
            (distributionPerSecond * SECONDS_PER_YEAR * APY_PRECISION) /
            stakedTokenTotalSupply;
    }

    /**
     * @notice Returns user data of the Staked Token
     * @param stakedToken The address of the StakedToken asset
     * @param user The address of the user
     */
    function _getStakedTokenUserData(
        AggregatedStakedSmartLendV3 stakedToken,
        address user
    ) internal view returns (StakedTokenUserData memory data) {
        data.stakedTokenUserBalance = stakedToken.balanceOf(user);
        data.rewardsToClaim = stakedToken.getTotalRewardsBalance(user);
        data.underlyingTokenUserBalance = IERC20(stakedToken.STAKED_TOKEN())
            .balanceOf(user);
        data.stakedTokenRedeemableAmount = stakedToken.previewRedeem(
            data.stakedTokenUserBalance
        );
        (data.userCooldownTimestamp, data.userCooldownAmount) = stakedToken
            .stakersCooldowns(user);
    }
}
