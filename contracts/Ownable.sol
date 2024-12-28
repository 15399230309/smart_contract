// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

//state variables;
// global variables;
//function modifier
// function
//error handling

contract Ownable {
    address public owner;
    constructor()  {
        owner = msg.sender;
    }
    modifier  onlyOwner() {
        require(msg.sender == owner, "NOT owner");
        _;

    }

    function setOwner(address _newOwner) external  onlyOwner {
        require(_newOwner != address(0),"invalid address");
        owner = _newOwner;
    }


    function anyOneCall(uint _num) pure external returns (uint) {
        return _num;
    }

    function ownerCall(uint _num ) view  external onlyOwner returns(address,uint){

        return (msg.sender  ,_num);
    }

}