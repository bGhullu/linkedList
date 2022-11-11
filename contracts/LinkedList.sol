// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "hardhat/console.sol";

contract Quest {
    struct Queue {
        // address user;
        uint256 depositAmount;
        uint256 next;
        uint256 prev;
    }
    mapping(uint256 => Queue) queue;
    uint256 position;
    uint256 head = 1;
    uint256 tail = 0;

    function enqueue(uint amount) public {
        Queue memory data;
        tail += 1;
        data.prev = tail;
        position += 1;
        uint prev = data.prev - 1;
        uint next = tail;
        data = Queue(amount, next, prev);
        queue[position] = data;
        // data.prev = tail;
    }

    function dequeue() public returns (Queue memory data) {
        if (tail >= head) {
            // non-empty queue
            if (data.prev >= data.next) {
                data = queue[data.next];
                delete queue[data.next];
                data.next += 1;
            }
            data = queue[head];
            delete queue[head];
            head += 1;
        } else {
            console.log("No more queue");
        }
    }

    function getData(uint num) public view returns (Queue memory) {
        return queue[num];
    }
}
