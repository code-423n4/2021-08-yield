// SPDX-License-Identifier: MIT
// Taken from https://github.com/Uniswap/uniswap-lib/blob/master/contracts/libraries/MinimalTransferHelper.sol

pragma solidity >=0.6.0;

import "../../interfaces/external/IERC20.sol";
import "../RevertMsgExtractor.sol";


// helper methods for interacting with ERC20 tokens and sending ETH that do not consistently return true/false
library MinimalTransferHelper {
    function safeTransfer(
        IERC20 token,
        address to,
        uint256 value
    ) internal {
        (bool success, bytes memory data) = address(token).call(abi.encodeWithSelector(IERC20.transfer.selector, to, value));
        if (!(success && (data.length == 0 || abi.decode(data, (bool))))) revert(RevertMsgExtractor.getRevertMsg(data));
    }
}