// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
// Data locations - storage, memory and calldata

contract DataLocations {

    struct MyStruct {
        uint256 foo;
        string text;
    }

    mapping (address =>MyStruct ) myStructs;

    function examples() external  {
        myStructs[msg.sender] =  MyStruct({foo:123,text:"bar"});

        //修改链上数据
        // MyStruct storage myStruct = myStructs[msg.sender]; 

        // myStruct.text = "foo" ;
        //修改内存数据
        MyStruct memory myStructReadOnly = myStructs[msg.sender];
        myStructReadOnly.foo = 456;

    }

    function example2 (uint[] memory y,string memory s )external pure returns (MyStruct memory){
   
        uint  b = y[1];
        string memory c = s;
        MyStruct memory a = MyStruct({foo:b,text:c});  
        return a;

    }


    function example3(uint[] calldata y,string memory s )external  returns (uint[] memory){
   
        uint[] memory memArr = new uint[](3);
        memArr[0] = y[1];
        _internal(y);
        return memArr;

    }

    function _internal(uint[] calldata y )  private    {
   
        uint x=y[0];

    }










}