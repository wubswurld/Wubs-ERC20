pragma solidity ^0.5.0;
contract wubs {
    address owner;
    mapping (address => uint256) theBalance;
    mapping (address => mapping (address => uint256)) theAllowance;
    uint256 totalTokens;
    
    constructor () public {
        owner = msg.sender;
        theBalance[owner] = 10000000;
        totalTokens = theBalance[owner];
    }
    
    modifier onlyOwner {
        require (owner == msg.sender);
        
        _;
    }
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    //. [Triggered when tokens are transferred.]
    
    
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    //[Triggered whenever approve(address _spender, uint256 _value) is called.]
    
    function totalSupply() public view returns (uint256 totalSupp){
        totalSupp = theBalance[owner];
        return(totalSupp);
    }
    // [Get the total token supply]
    
    function balanceOf(address _owner) public view returns (uint256 balance) {
        balance = theBalance[_owner];
        return (balance);
    }
    // [Get the account balance of another account with address _owner]
    
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require (_value >= 0);
        theBalance[msg.sender] -= _value;
        theBalance[_to] += _value;
        return (success);
    }
    // [Send _value amount of tokens to address _to]
    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(theBalance[_from] >= _value);
        require(theAllowance[_from][msg.sender] >= _value);
        theAllowance[_from][msg.sender] -= _value;
        theBalance[_from] -= _value;
        theBalance[_to] += _value;
        emit Transfer(_from, _to, _value);
        return (success);
    }
    //[Send _value amount of tokens from address _from to address _to]
    
    function approve(address _spender, uint256 _value) public returns (bool success) {
        emit Approval(msg.sender, _spender, _value);
        require (theBalance[msg.sender] >= _value);
        theAllowance[msg.sender][_spender] = _value;
        return (success);
    }
    
    // [Allow _spender to withdraw from your account, multiple times, up to the _value amount. If this function is called again it overwrites the current allowance with _value]
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        remaining = theAllowance[_owner][_spender];
        return (remaining);
    }
    // [Returns the amount which _spender is still allowed to withdraw from _owner]
   
     function   buyTokens() public payable{
         require (theBalance[owner] >= msg.value);
         theBalance[msg.sender] += msg.value;
         theBalance[owner] -= msg.value;
     }
     
     function withdrawdollaDolla() onlyOwner public {
         msg.sender.transfer(address(this).balance);
         
     }
}