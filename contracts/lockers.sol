pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract Lockers is ERC20 {

    event locked(uint256 _lockedAmount);
    event unLocked(uint256 _lockedAmount);
    event fallbackEvent(bool resp);
    event receiveEvent(bool resp);

    mapping(address => uint256) public lockPeriod;
    mapping(address => uint256) public lockedAmount;

    address public owner_;

    constructor() ERC20("Lockers","LKRS") {
        _mint(msg.sender, 1000000000000000000000000000000);
        owner_ = _msgSender();
    }

    fallback() external payable{
        emit fallbackEvent(true);
    }
    receive() external payable{
        emit receiveEvent(true);
    }

    function lock(uint256 _amount) public returns(bool){
        require(balanceOf(msg.sender) >= _amount,"You dont have enough balance to lock!");
        require(userToContract(msg.sender, _amount),"Failed to transfer from user to contract");
        lockPeriod[msg.sender] = block.timestamp + 1 days;
        lockedAmount[msg.sender] = _amount;
        emit locked(_amount);
        return true;
    }

    function unlock(uint256 _amount) public returns(bool){
        require(lockedAmount[msg.sender] == _amount,"You can only unlock all the amount.");
        require(block.timestamp >= lockPeriod[msg.sender],"Lock time is not over yet !");
        require(contractToUser(msg.sender, _amount),"Failed to transfer from contract to user");
        lockedAmount[msg.sender] = 0;
        lockPeriod[msg.sender] = 0;
        emit unLocked(_amount);
        return true;
    }

    function transferFromContract(address payable _to, uint256 _amount) external returns(bool){
        require(_msgSender() == owner_,"Only owner have access to transfer !");
        require(address(this).balance >= _amount,"Insufficient balance !");
        (bool sent,) = _to.call{value:_amount}('');
        return sent;
    }
}