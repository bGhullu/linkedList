// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract LinkedList {
    struct Queue {
        address user;
        uint256 depositAmount;
        uint256 next;
        uint256 prev;
    }
    mapping(uint256 => Queue) queue;
    uint256 position;
    uint256 head;
    uint256 tail;

    function enqueue(Queue memory data) public {
        tail += 1;
        queue[tail] = data;
    }

    function dequeue() public returns (Queue memory data) {
        require(tail >= head); // non-empty queue

        data = queue[head];

        delete queue[head];
        head += 1;
    }

    function getData(uint num) public view returns (Queue memory) {
        return queue[num];
    }
}
