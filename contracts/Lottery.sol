// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Lottery{
    address public owner; 
    address payable[] public  players;
    uint public lotteryid;
    mapping (uint => address payable ) public lotteryhistory;
 
    constructor(){
        owner = msg.sender;
        lotteryid = 1;
    }

    function getBalance() public view returns (uint){
        return  address(this).balance;
    }
    function getWinnerLottery(uint id) public  view returns (address payable ){
        return lotteryhistory[id];
    }
    function getPlayers() public  view returns(address payable [] memory){
        return  players;
    }

    function enter() public  payable  {
        require(msg.value > .01 ether);

        //address of players
        players.push(payable (msg.sender));
    }
function getrandomnumber() public  view returns (uint){
    return uint(
        keccak256(abi.encodePacked(owner, block.timestamp))
    );
}

function pickWinner()public onlyOwner {

    
   uint index = getrandomnumber() % players.length;
   players[index].transfer(address(this).balance);

    lotteryhistory[lotteryid] = players[index];
    
   lotteryid++;

  

   //reset the array
   players = new address payable [](0);
}

modifier onlyOwner(){
    require(msg.sender  == owner);
    _;
}

}