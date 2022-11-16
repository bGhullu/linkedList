// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

error TimeLock__NotAuthorised();
error TimeLock__TxAlreadyInQueue(bytes32 txId);
error TimeLock__TimeNotInRange(uint blockTimestamp, uint timestamp);
error TimeLock__TimestampNotPassed(uint blockTimestamp, uint timestamp);
error TimeLock__TimestampExpiredError(uint blockTimestamp, uint timestamp);
error TimeLock__NotFunctionProvided();
error TimeLock__TransactionFailed();
error TimeLock__TransactionNotQueued(bytes32 txId);
