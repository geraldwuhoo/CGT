pragma solidity ^0.4.19;

import './IERC20.sol';
import './SafeMath.sol';

contract GooseToken is IERC20 {

	using SafeMath for uint256;

	uint public _totalSupply = 1000000000000000000000000;

	string public constant symbol = "GST";
	string public constant name = "Goose Token";
	uint8 public constant decimals = 18;

	uint256 public constant RATE = 10000;

	address public owner;

	mapping(address => uint256) balances;
	mapping(address => mapping(address => uint256)) allowed;

	function () payable
	{
		createTokens();
	}

	function GooseToken()
	{
		owner = msg.sender;
		balances[msg.sender] = _totalSupply;
	}

	function createTokens() payable
	{
		if(msg.value > 0)
		{
			uint256 tokens = msg.value.mul(RATE);
			balances[msg.sender] = balances[msg.sender].add(tokens);
			_totalSupply = _totalSupply.add(tokens);

			owner.transfer(msg.value);
		}
	}

	function totalSupply() constant returns (uint256 totalSupply)
	{
		return _totalSupply;
	}

	function balanceOf(address _owner) constant returns (uint256 balance)
	{
		return balances[_owner];
	}

	function transfer(address _to, uint256 _value) returns (bool success)
	{
		if(balances[msg.sender] >= _value && balances[_to] + _value > balances[_to])
		{
			balances[msg.sender] = balances[msg.sender].sub(_value);
			balances[_to] = balances[_to].add(_value);
			Transfer(msg.sender, _to, _value);
			return true;
		}
		else
		{
			return false;
		}
	}

	function transferFrom(address _from, address _to, uint256 _value) returns (bool success)
	{
		if(balances[_from] >= _value && allowed[_from][msg.sender] >= _value && balances[_to] + _value > balances[_to])
		{
			balances[_to] = balances[_to].add(_value);
			balances[_from] = balances[_from].sub(_value);
			allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
			Transfer(_from, _to, _value);
			return true;
		}
		else
		{
			return false;
		}
	}

	function approve(address _spender, uint256 _value) returns (bool success)
	{
		allowed[msg.sender][_spender] = _value;
		Approval(msg.sender, _spender, _value);
		return true;
	}

	function allowance(address _owner, address _spender) constant returns (uint256 remaining)
	{
		return allowed[_owner][_spender];
	}
}
