// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Lottery{
    address public owner; 
    address payable[] public  players;

    constructor(){
        owner = msg.sender;
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

function pickWinner()public {
    require(msg.sender  == owner);
   uint index = getrandomnumber() % players.length;
   players[index].transfer(address(this).balance);

   //reset the array
   players = new address payable [](0);
}

}