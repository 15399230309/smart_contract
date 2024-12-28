// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
contract Structs{

    struct Car {
        string model;
        uint year;
        address owner;
    }

    Car public  car;
    Car[] public  cars;
//某个地址有多辆car
    mapping (address => Car[]) public  carsByOwner;

    function examples ()  external  {
        //初始化结构体的3种方式
        Car memory toyota = Car("fengtian",1999,msg.sender);
        Car memory lambo = Car({year:1950,model:"ramborghini",owner:msg.sender});
        Car memory tesla;
        tesla.model = "Tesla";
        tesla.year = 2000;
        tesla.owner = msg.sender;
        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);
        cars.push(Car("Ferrari",2020,msg.sender));
        //使用storage可以把变量保存在链上，memory是将变量保存在内存中；
        Car storage _car = cars[0];
        _car.year = 1920;
        // ArrayCopyLib.copyArray(cars, carsByOwner[msg.sender]);
        // carsByOwner[msg.sender] = cars；
        Car[] storage ownerCars = carsByOwner[msg.sender];
        for (uint i = 0; i < cars.length; i++) {
        ownerCars.push(cars[i]);
    }

        delete _car.owner; 
        delete cars[1]; //将索引为1的位置Car实力置为默认值
    }

    function getOwner( ) public view  returns (address) {
        return msg.sender;
    }
}

