// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.7;
import "@openzeppelin/contracts/access/Ownable.sol";

contract GasContract is Ownable{

    uint256 public totalSupply;
    uint128 paymentCounter;

    address [5] public administrators;
    enum PaymentType { Unknown, BasicPayment, Refund, Dividend, GroupPayment }
    PaymentType constant defaultPayment = PaymentType.Unknown;

    mapping(address => uint256) public balances;
    mapping(address => Payment[]) payments;
    //mapping(address=>uint256) lastUpdateRecord; // when a payment record was last for a user   


    struct Payment {
      uint128 paymentID;
      uint128 amount;
      PaymentType paymentType;
      address recipient;
      string recipientName;  // max 12 characters
//      uint256 lastUpdate;
//      address updatedBy;

      
    }

    modifier onlyAdmin {
        require (checkForAdmin(msg.sender), "Gas Contract -  Caller not admin" );
        _;
    }

    event supplyChanged(address , uint256 indexed);
    event Transfer(address , uint256);
    event PaymentUpdated(address  admin, uint256  ID, uint256  amount, string  recipient);


   constructor(address[] memory _admins) {
      totalSupply = 10000;
      balances[msg.sender] = totalSupply;
        for (uint256 ii = 0;ii<administrators.length ;ii++){
            if(_admins[ii] != address(0)){ 
                administrators[ii] = _admins[ii];
            } 
        }
      
   }
   
   function welcome() external pure returns (string memory msg_){
       msg_ =  "hello !";
   }

   function updateTotalSupply() external onlyOwner {
      totalSupply = totalSupply + 1000;
      balances[msg.sender] = totalSupply;
      emit supplyChanged(msg.sender,totalSupply);
   }

   function checkForAdmin(address _user) public view returns (bool) {
       bool admin = false;
       for (uint256 ii = 0; ii< administrators.length;ii++ ){
          if(administrators[ii] ==_user){
              admin = true;
              break;
          }
       }
       return admin;
   }
   
   function transfer(address _recipient, uint128 _amount, string calldata _name) external {
      require(balances[msg.sender] >= _amount,"Gas Contract - Transfer function - Sender has insufficient Balance");
      require(bytes(_name).length < 13,"Gas Contract - Transfer function -  The recipient name is too long, there is a max length of 12 characters");
      balances[msg.sender] -= _amount;
      balances[_recipient] += _amount;
      emit Transfer(_recipient, _amount);
      Payment memory payment;
      payment.paymentType = PaymentType.BasicPayment;
      payment.recipient = _recipient;
      payment.amount = _amount;
      payment.recipientName = _name;
      payment.paymentID = ++paymentCounter;
      payments[msg.sender].push(payment);
   }
     
    function updatePayment(address _user, uint128 _ID, uint128 _amount) external onlyAdmin {
        require(_ID > 0,"Gas Contract - Update Payment function - ID must be greater than 0");
        require(_amount > 0,"Gas Contract - Update Payment function - Amount must be greater than 0");
        require(_user != address(0) ,"Gas Contract - Update Payment function - Administrator must have a valid non zero address");
       // uint256 lastUpdate = block.timestamp;
        //address updatedBy = msg.sender;
        for (uint256 ii=0;ii<payments[_user].length;ii++){
            if(payments[_user][ii].paymentID==_ID){
            //    payments[_user][ii].lastUpdate =  lastUpdate;
            //    payments[_user][ii].updatedBy = updatedBy;
               payments[_user][ii].amount = _amount;
               //lastUpdateRecord[msg.sender] = uint128(block.timestamp);
               emit PaymentUpdated(msg.sender, _ID, _amount,payments[_user][ii].recipientName);
               break;
            }
        }
    }


   function getPayments(address _user) external view returns (Payment[] memory) {
      require(_user != address(0) ,"Gas Contract - getPayments function - User must have a valid non zero address");
       return payments[_user];
   }
}
