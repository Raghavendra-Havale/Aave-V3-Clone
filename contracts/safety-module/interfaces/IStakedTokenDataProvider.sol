// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;
pragma experimental ABIEncoderV2;

/**
 * @title IStakedTokenDataProvider
 * @notice It defines the basic interface of the Staked Token Data Provider
 */
interface IStakedTokenDataProvider {
    struct StakedTokenData {
        uint256 stakedTokenTotalSupply;
        uint256 stakedTokenTotalRedeemableAmount;
        uint256 stakeCooldownSeconds;
        uint256 stakeUnstakeWindow;
        uint256 stakedTokenPriceEth;
        uint256 rewardTokenPriceEth;
        uint256 stakeApy;
        uint128 distributionPerSecond;
        uint256 distributionEnd;
    }

    struct StakedTokenUserData {
        uint256 stakedTokenUserBalance;
        uint256 stakedTokenRedeemableAmount;
        uint256 underlyingTokenUserBalance;
        uint256 rewardsToClaim;
        uint40 userCooldownTimestamp;
        uint216 userCooldownAmount;
    }

    /**
     * @notice Return the address of the ETH price feed, USD denominated
     * @return The address of the ETH price feed, USD denominated, expressed with 8 decimals
     */
    function ETH_USD_PRICE_FEED() external returns (address);

    /**
     * @notice Return the address of the SMARTLEND price feed, ETH denominated
     * @return The address of the SMARTLEND price feed, ETH denominated, expressed with 18 decimals
     */
    function SMARTLEND_PRICE_FEED() external returns (address);

    /**
     * @notice Return the address of the BPT price feed, ETH denominated
     * @return The address of the BPT price feed, ETH denominated, expressed with 18 decimals
     */
    function BPT_PRICE_FEED() external returns (address);

    /**
     * @notice Return the address of the SMARTLEND token
     * @return The address of the SMARTLEND token
     */
    function SMARTLEND() external returns (address);

    /**
     * @notice Return the address of the Staked SMARTLEND token
     * @return The address of the StkSMARTLEND token
     */
    function STAKED_SMARTLEND() external returns (address);

    /**
     * @notice Return the address of the BPT token
     * @return The address of the BPT token
     */
    function BPT() external returns (address);

    /**
     * @notice Return the address of the Staked BPT token
     * @return The address of the StkBPT token
     */
    function STAKED_BPT() external returns (address);

    /**
     * @notice Returns data of all Staked Tokens
     * @return stkSmartLendData An object with StkSmartLend data
     * @return stkBptData An object with StkBpt data
     * @return ethPrice The price of ETH, USD denominated (expressed with 8 decimals)
     */
    function getAllStakedTokenData()
        external
        view
        returns (
            StakedTokenData memory stkSmartLendData,
            StakedTokenData memory stkBptData,
            uint256 ethPrice
        );

    /**
     * @notice Returns data of Staked SmartLend
     * @return stkSmartLendData An object with StkSmartLend data
     */
    function getStkSmartLendData()
        external
        view
        returns (StakedTokenData memory stkSmartLendData);

    /**
     * @notice Returns data of Staked Bpt SmartLend
     * @return stkBptData An object with StkBpt data
     */
    function getStkBptData()
        external
        view
        returns (StakedTokenData memory stkBptData);

    /**
     * @notice Returns user data of all Staked Tokens
     * @param user The address of the user
     * @return stkSmartLendData An object with StkSmartLend data
     * @return stkSmartLendUserData An object with user data of StkSmartLend
     * @return stkBptData An object with StkBpt data
     * @return stkBptUserData An object with user data of StkBpt
     * @return ethPrice The price of ETH, USD denominated (expressed with 8 decimals)
     */
    function getAllStakedTokenUserData(
        address user
    )
        external
        view
        returns (
            StakedTokenData memory stkSmartLendData,
            StakedTokenUserData memory stkSmartLendUserData,
            StakedTokenData memory stkBptData,
            StakedTokenUserData memory stkBptUserData,
            uint256 ethPrice
        );

    /**
     * @notice Returns user data of Staked SmartLend
     * @param user The address of the user
     * @return stkSmartLendData An object with StkSmartLend data
     * @return stkSmartLendUserData An object with user data of StkSmartLend
     */
    function getStkSmartLendUserData(
        address user
    )
        external
        view
        returns (
            StakedTokenData memory stkSmartLendData,
            StakedTokenUserData memory stkSmartLendUserData
        );

    /**
     * @notice Returns user data of Staked Bpt SmartLend
     * @param user The address of the user
     * @return stkBptData An object with StkBpt data
     * @return stkBptUserData An object with user data of StkBpt
     */
    function getStkBptSmartLendUserData(
        address user
    )
        external
        view
        returns (
            StakedTokenData memory stkBptData,
            StakedTokenUserData memory stkBptUserData
        );
}
