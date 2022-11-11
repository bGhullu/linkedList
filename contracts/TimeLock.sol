// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

error TimeLock__NotAuthorised();
error TimeLock__TxAlreadyInQueue(bytes32 txId);
error TimeLock__TimeNotInRange(uint blockTimestamp, uint timestamp);
error TimeLock__TimestampNotPassed(uint blockTimestamp, uint timestamp);
error TimeLock__TimestampExpiredError(uint blockTimestamp, uint timestamp);

contract TimeLock {
    event Queue(
        bytes32 indexed txId,
        address indexed target,
        uint value,
        string func,
        uint timestamp
    );
    address private owner;
    mapping(bytes32 => bool) public inQueue;
    uint256 private MIN_WAIT_TIME;
    uint256 private MAX_WAIT_TIME;
    uint256 private GRACE_PERIOD;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert TimeLock__NotAuthorised();
        }
        _;
    }

    function getTransactionId(
        address target,
        uint256 value,
        string calldata func,
        uint timestamp
    ) public view returns (bytes32) {
        return keccak256(abi.encode(target, value, func, timestamp));
    }

    function queue(
        address target,
        uint256 value,
        string calldata func,
        uint timestamp
    ) external onlyOwner returns (bytes32 txId) {
        txId = getTransactionId(target, value, func, timestamp);
        if (inQueue[txId]) {
            revert TimeLock__TxAlreadyInQueue(txId);
        }
        if (
            timestamp < block.timestamp + MIN_WAIT_TIME ||
            timestamp > block.timestamp + MAX_WAIT_TIME
        ) {
            revert TimeLock__TimeNotInRange(block.timestamp, timestamp);
        }
        inQueue[txId] = true;
        emit Queue(txId, target, value, func, timestamp);
    }

    function execute(
        address target,
        uint256 value,
        string calldata func,
        uint timestamp
    ) external onlyOwner returns (bytes memory) {
        bytes32 txId = getTransactionId(target, value, func, timestamp);
        if (block.timestamp < timestamp) {
            revert TimeLock__TimestampNotPassed(block.timestamp, timestamp);
        }
        if (block.timestamp > timestamp + GRACE_PERIOD) {
            revert TimeLock__TimestampExpiredError(
                block.timestamp,
                timestamp + GRACE_PERIOD
            );
        }
        inQueue[txId] = false;
    }
}
