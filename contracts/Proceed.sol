// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Proceed {
    address private timelock;

    constructor(address _timelock) {
        timelock = _timelock;
    }

    function exchange() external {
        require(msg.sender == timelock, "notAuthorised");
    }
}
