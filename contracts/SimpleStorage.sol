// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract SimpleStorage {

    string public  text;

//不同存储位置存储以下字符串对于gas消耗值
// aaaaaaaaaaaaaaaaaaaaaaaaaaaaa 
// calldata 51404 
// memory 51581

    function set (string calldata _text ) external  {
        text = _text;
    }

    function get ()external  view returns (string memory)  {
        return text;
    }

}