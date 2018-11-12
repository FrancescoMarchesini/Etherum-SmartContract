pragma solidity ^0.4.25;

contract Hello{
    string hello;
    
    constructor() public{
        hello = "hello world";
    }
    
    
    function getHello() public view returns(string){
        return hello;
    }
}
