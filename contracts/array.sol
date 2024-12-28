// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

//Array -动态或固定长度
//初始化
// insert、push、get、update、delete、pop、length
//create arr in memory
// returning array from function


contract ArrayShow{

    uint[] public  nums=[1,2,3];
    uint[1000] public numsFixed=[4,5,6];

    function examples() external returns(uint,uint) {
        uint x ;
        uint len;
        nums.push(4); // [1,2,3,4]
        x =  nums[1]; //2
        nums[2] = 7777;
        delete nums[1]; //[1,0,7777,4]
        nums.pop(); //[1,0,7777]
        len = nums.length;
        //create array in memory 
        uint[] memory a = new uint[](5);
    }

    function returnArray() external view returns (uint[] memory){
        return nums;
    }



}