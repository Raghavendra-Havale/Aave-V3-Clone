// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.7.5;

import {IERC20} from "../interfaces/IERC20.sol";
import {SafeMath} from "../open-zeppelin/SafeMath.sol";
import {VersionedInitializable} from "../utils/VersionedInitializable.sol";

/**
 * @title LendToSmartLendMigrator
 * @notice This contract implements the migration from LEND to SmartLend token
 * @author SmartLend
 */
contract LendToSmartlendMigrator is VersionedInitializable {
    using SafeMath for uint256;

    IERC20 public immutable SmartLend;
    IERC20 public immutable LEND;
    uint256 public immutable LEND_SmartLend_RATIO;
    uint256 public constant REVISION = 1;

    uint256 public _totalLendMigrated;

    /**
     * @dev emitted on migration
     * @param sender the caller of the migration
     * @param amount the amount being migrated
     */
    event LendMigrated(address indexed sender, uint256 indexed amount);

    /**
     * @param smartlend the address of the SmartLend token
     * @param lend the address of the LEND token
     * @param lendSmartLendRatio the exchange rate between LEND and SmartLend
     */
    constructor(
        IERC20 smartlend,
        IERC20 lend,
        uint256 lendSmartLendRatio
    ) public {
        SmartLend = smartlend;
        LEND = lend;
        LEND_SmartLend_RATIO = lendSmartLendRatio;
    }

    /**
     * @dev initializes the implementation
     */
    function initialize() public initializer {}

    /**
     * @dev returns true if the migration started
     */
    function migrationStarted() external view returns (bool) {
        return lastInitializedRevision != 0;
    }

    /**
     * @dev executes the migration from LEND to SmartLend. Users need to give allowance to this contract to transfer LEND before executing
     * this transaction.
     * @param amount the amount of LEND to be migrated
     */
    function migrateFromLEND(uint256 amount) external {
        require(lastInitializedRevision != 0, "MIGRATION_NOT_STARTED");

        _totalLendMigrated = _totalLendMigrated.add(amount);
        LEND.transferFrom(msg.sender, address(this), amount);
        SmartLend.transfer(msg.sender, amount.div(LEND_SmartLend_RATIO));
        emit LendMigrated(msg.sender, amount);
    }

    /**
     * @dev returns the implementation revision
     * @return the implementation revision
     */
    function getRevision() internal pure override returns (uint256) {
        return REVISION;
    }
}
