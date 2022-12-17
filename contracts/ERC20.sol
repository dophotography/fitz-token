pragma solidity ^0.5.0;

contract ERC20Interface {
    function totalSupply() public view returns(uint256);
    function balanceOf(address tokenOwner) public view returns(uint balance);
    function allowance(address tokenOwner, address spender) public returns(uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint256 tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint256 tokens);
}

contract Fitz is ERC20Interface {
    string public name;
    string public symbol;
    uint8 public decimals;

    uint256 public _totalSupply;    

    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;
    
    constructor() public {
        name = "Fitz";
        symbol = "FTZ";
        decimals = 18;
        _totalSupply = 10000000000000000;

        balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function totalSupply() public view returns(uint) {
    return _totalSupply - balances[address(0)];
    }

    function balanceOf(address tokenOwner) public view returns(uint balance) {
        return balances[tokenOwner];
    }

    function allowance(address tokenOwner, address spender) public returns(uint remaining) {
        return allowed[tokenOwner][spender];
    }

    function approve(address spender, uint tokens) public returns(bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function transfer(address to, uint tokens) public returns(bool success) {
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    function transferFrom(address from, address to, uint tokens) public returns(bool success) {
        emit Transfer(from, to, tokens);
        return true;
    }
}