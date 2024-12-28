// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;



contract Event {
    event Log (string message,uint val);
    event indexedLog(address indexed sender,uint val);
    enum ActionSet { Buy, Hold, Sell}
    uint256 public immutable IMMUTABLE_NUM = 9999999999;
    address public immutable IMMUTABLE_ADDRESS;
    uint256 public immutable IMMUTABLE_BLOCK;
    uint256 public immutable IMMUTABLE_TEST;
    ActionSet public _enum; // 第1个内容Buy的索引0
    function example ()external  {
        emit Log("foo", 123);
        emit indexedLog(msg.sender, 100);

    }

    event Message(address indexed  _from , address indexed _to,string message );


    function SendMessage(address _to,string calldata message) external {
        emit Message(msg.sender, _to, message);
    }


    // function example2 () external {
    // _enum = 2;
    
    // emit Log("123", _enum.Hold);

    // }
    function set_cont (uint  _value) external pure returns (uint a ) {
       a = _value + 1;
    }

}