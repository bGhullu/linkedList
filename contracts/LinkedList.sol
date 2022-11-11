// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "hardhat/console.sol";

contract LinkedList {
    struct Queue {
        // address user;
        uint256 depositAmount;
        uint256 prev;
        uint256 next;
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
        data = Queue(amount, prev, next);
        queue[position] = data;
        // data.prev = tail;
    }

    function dequeue() public returns (Queue memory data) {
        if (tail >= head) {
            // non-empty queue
            data = queue[head];
            delete queue[head];
            head += 1;
        } else {
            console.log("No more queue");
        }
    }

    function remove(uint256 id) external {
        Queue storage data = queue[id];

        if (head == id) {
            head = data.next;
        }
        if (tail == id) {
            tail = data.prev;
        }
        if (data.prev != 0) {
            queue[data.prev].next = data.next;
        }
        if (data.next != 0) {
            queue[data.next].prev = data.prev;
        }
        queue[id].next = 0;
        queue[id].prev = 0;
        delete queue[id];
    }

    function getData(uint256 id) public view returns (Queue memory) {
        return queue[id];
    }
}
