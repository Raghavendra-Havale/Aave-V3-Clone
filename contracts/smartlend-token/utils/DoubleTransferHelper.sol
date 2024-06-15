// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.7.5;

import "../interfaces/IERC20.sol";

contract DoubleTransferHelper {
    IERC20 public immutable SMARTLEND;

    constructor(IERC20 smartlend) public {
        SMARTLEND = smartlend;
    }

    function doubleSend(address to, uint256 amount1, uint256 amount2) external {
        SMARTLEND.transfer(to, amount1);
        SMARTLEND.transfer(to, amount2);
    }
}
