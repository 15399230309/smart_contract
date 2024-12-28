// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

//mapping (bytes32 => mapping (address=>bool));

contract AccessControl {
    mapping(bytes32 => mapping(address => bool)) private roles;
    //0xf23ec0bb4210edd5cba85afd05127efcd2fc6a781bfed49188da1081670b22d8
    bytes32 public constant ADMIN = keccak256(abi.encodePacked("admin"));

    //0xcb61ad33d3763aed2bc16c0f57ff251ac638d3d03ab7550adfd3e166c2e7adb6
    bytes32 public constant USER = keccak256(abi.encodePacked("user"));

    constructor() {
        roles[ADMIN][msg.sender] = true;
    }

    // 定义一个设置权限的事件，如果设置权限了，会触发调用
    event RoleGrant(bytes32 indexed role, address indexed account);

    event RoleRevoked(bytes32 indexed role, address indexed account);

    modifier onlyRole(bytes32 role) {
        //做一个装饰器，限制操作者必须是管理员权限
        require(roles[role][msg.sender], "caller not auth");
        _;
    }

    // set roles fun
    function grantRole(bytes32 role, address account) external onlyRole(ADMIN) {
        //在roles中某个角色的映射里为某个账号设置映射值为true
        _grantRole(role, account);
    }

    function _grantRole(bytes32 role, address account) internal {
        roles[role][account] = true;
        emit RoleGrant(role,account);
    }

    function revokeRole(bytes32 role , address account  ) external  {

        _revokeRole(role,account);


    }

    function _revokeRole(bytes32 role , address account  )  internal {
        roles[role][account] = false;
        emit RoleRevoked(role,account);
    }
    struct result  {
        address  account;
        bool     flag;
    }

    function get_role(bytes32 role,address account) view external returns (bool)   {
  
        return  roles[role][account];
    }

    // struct RoleStruct {
    //     address account;
    //     boool  flag;
    // }

    // function get_role_struct(bytes32 role) view external returns (RoleStruct )   {

    //     RoleStruct.account = roles[role].


    //     return  roles[role][account];
    // }

}
