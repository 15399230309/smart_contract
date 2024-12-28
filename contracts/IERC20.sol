// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IERC20 {
    //返回代表总供给
    function totalSupply() external view returns (uint256);
   // 返回account账户余额
    function balanceOf(address account) external view returns (uint256);
    // 从合约调用者转账给recipient ,转账数量amount
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);
    //返回授权额度，返回owner账户授权给spender账户的额度，默认为0
    //当{approve} 或 {transferFrom} 被调用时，`allowance`会改变.
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);
    //调用者账户给spender账户授权amount数量代币
    function approve(address spender, uint256 amount) external returns (bool);

    //通过授权机制，从from账户向to账户转账amount数量代笔，转账的部分会从调用者的allowance中扣除
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

contract ERC20 is IERC20 {
    mapping (address=>uint256) public balanceOf;
    mapping (address=> mapping (address => uint256) )public allowance;
    uint256 public  totalSupply;
    string  public  name;
    string public symbol;
    uint8 public  decimals=18;
    event Transfer(address indexed  sender, address indexed to ,uint256 amount);
    event Approval(address indexed owner,address indexed spender,uint256 value);
    constructor ( string memory _name,string memory _symbol){
        name = _name;
        symbol = _symbol;
    }
    // 从合约调用者转账给recipient ,转账数量amount
    function transfer(address recipient, uint256 amount)
        external
        returns (bool) {

            balanceOf[msg.sender] -= amount;
            balanceOf[recipient] += amount;
            emit Transfer(msg.sender, recipient, amount);
            return  true;
        }
    //调用者账户给spender账户授权amount数量代币
    function approve(address spender, uint256 amount) external returns (bool){

        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return  true;
    }

    //通过授权机制，从from账户向to账户转账amount数量代笔，转账的部分会从调用者的allowance中扣除
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool){
        allowance[from][msg.sender] -= amount;
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }

    //铸币函数：铸造代币函数，不在IERC20标准中。这里为了教程方便，任何人可以铸造任意数量的代币，实际应用中会加权限管理，只有owner可以铸造代币：
    function mint(uint amount) external {
        //缺少权限管理逻辑
        balanceOf[msg.sender] += amount;
        totalSupply +=amount;
        emit Transfer(address(0), msg.sender, amount);

    }
    //burn函数：销毁代币函数，不在IERC20标准中。
    function burn(uint amount) external  {
        balanceOf[msg.sender] -= amount;
        totalSupply -=amount;
        emit Transfer(msg.sender, address(0), amount);
    }

}



// 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4   10050
// 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2   50
// 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db   0     1000