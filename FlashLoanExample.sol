//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzepplelin/contracts/utils/math/SafeMath.sol";
import "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract FlashLoanExample is FlashLoanSimpleReceiverBase {
    using SafeMath for uint256;
    event Log(address asset, uint256 val);

    constructor(IPoolAddressesProvider provider)
        public
        FlashLoanSimpleReceiverBase(provider)
    {}

    function createFlashLoan(address asset, uint256 amount) external {
        address receiver = address(this);
        bytes memory params = ""; // use this to pass arbitrary data to executeOperation
        uint16 referralCode = 0;
    }

    function executeOperation(address asset, uint256 amount, uint256 premium, address initiator, bytes calldata params) external returns (bool) {
        // do things like arbitrage here
        // abi.decode(params) to decode params

        uint amountOwing = amount.add(premium);
        IERC20(asset).approve(address(POOL), amountOwing);
        emit Log(asset, amountOwing);
        return true;
    }
}
