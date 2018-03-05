pragma solidity ^0.4.18;

// Caller contract for EthernityFinancialOracle v0.2
// @ethernity.live


contract EthernityFinancialOracle {
    function requestEtherToUSD(bool _callBack , uint _gasPrice, uint _gasLimit) payable;
    function getPrice(uint _gasPrice,uint _gasLimit) public constant returns(uint _price);
    event Request (string _coin , string _againstCoin , address _address , uint _gasPrice , uint _gasLimit);
}

contract Caller {
    
    string public response; // Public getter to see the answer
    address public oracleAdd; // Oracle address
    address public owner;
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }


    function Caller() {
        owner = msg.sender;
        oracleAdd = 0x52a6c36047d6156d8e39842327ae9e0ae01efa57; // 0x121dDe0ae24F69E58c5a3ABD906D9B2D6a1B3481; // Kovan address
    }

    function EFOcallBack(string _response) {
        require(msg.sender == oracleAdd);
        response = _response;
    }


    // fallback function to receive Ethers
    function() payable {
    }

    // Main function: request

    function request(uint _gasPrice,uint _gasLimit) onlyOwner payable {
        EthernityFinancialOracle oracle = EthernityFinancialOracle(oracleAdd);
        oracle.requestEtherToUSD.value(oracle.getPrice(_gasPrice,_gasLimit))(true,_gasPrice,_gasLimit);
    }


    // Get actual price

    function getPrice(uint _gasPrice,uint _gasLimit) public constant returns(uint _price) {
        EthernityFinancialOracle oracle = EthernityFinancialOracle(oracleAdd);
        return oracle.getPrice(_gasPrice,_gasLimit);
    }

    // Admin

    function setOracleAdd(address _address) onlyOwner {
        oracleAdd = _address;
    }


}		