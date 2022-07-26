pragma solidity ^0.8.7;
contract BankSystem{
    address public owner;
    uint public createdtime;
    mapping(address => uint)public UserAccount;
    constructor() public{
        owner=msg.sender;

    }
  
    function ShowTotalBalance() public view returns(uint256){
        return owner.balance;
    }

    function ShowBalance() public view returns(uint256){
        return UserAccount[msg.sender];
    }
    function AddBalance()public payable{
        createdtime=block.timestamp;
        UserAccount[msg.sender] += msg.value;
}
     function Withdraw(uint amount) public payable {
         UserAccount[msg.sender]-=amount;
         payable(msg.sender).transfer(amount);
     }
      function TransferAmount(address payable userAddress, uint amount) public {
           UserAccount[msg.sender]-=amount;
           UserAccount[userAddress]+=amount;
      }
      function GetBalance() public view returns(uint){
           return (UserAccount[msg.sender]*((100+7*((block.timestamp)-createdtime))/100));
      }

}
