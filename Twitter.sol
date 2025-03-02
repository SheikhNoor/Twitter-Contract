// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 < 0.9.0;

contract Twitter{
    struct tweet{
        uint id;
        address author;
        string content;
    }

    struct Message{
        uint id;
        string content;
        address from;
        address to;
        uint createAt;
    }

    mapping (uint => tweet) public tweets;
    mapping (address => uint[]) public tweetsOff;
    mapping (uint => Message[]) public conversation;
    mapping (address=> mapping (address=>bool)) public  opetators;
    mapping (address=>address[]) public followong;

    uint nextId;
    uint nexxtMessage;



}