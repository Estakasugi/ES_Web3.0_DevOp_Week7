// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/*
    @author: ES_TAKASUGI
*/

import "./Ownable.sol";

contract DecentPrimalLotteryUser is Ownable {

    /******** Section 1-Variables *******/

    // structure for user of the lottery
    struct UserInfo { 
        string userName;
        uint32 totalCostInEther;  
        bool isWinnerOfCurrentPool;
        uint256 winningAmountOfCurrentPool;
    }


    // this data base is only interactable within the contracts and its heritage
    UserInfo[] internal usersDataLedger;


    /* some mappings for searchings
     * they are internal, we want only the address only able to interact with their own account(checking their user name or vise versa)
     * users are not allowed to check other users' address
     */
    mapping (string => address) internal userNameToAddress;  // This is the seraching map that given an userName, returns the its address.
    mapping (address => UserInfo) internal addressToUserInfo;  // This is the seraching map that given an address, returns the its user information
    // TO-DO: need to add a mapping to facilitate finding the max totalCost user
    mapping (string => UserInfo) internal userNameToUserInfo; // This is the seraching map that given an address, returns the its user information


    /******* Section 2-Modifiers *******/

    // This function modifier ensures that the address has a valid user account in the lottery system
    modifier validUser() {
        // solidity does not allow string comp, this is the standard way to handle  string comparison
        require( keccak256(abi.encodePacked(addressToUserInfo[msg.sender].userName)) != keccak256(abi.encodePacked("")), "User does not exist" ); 
        _;
    }


    /******* Section 3-Functions ******/

    // This function will create a UserInfo Struct and store it into usersDataLedger,
    // this function is interacable with functions/users/contracts outside of the contract
    function createUserInfo(string memory _userName) external  { // changed to external from public
        // TO-DO: Add user name legal/secure checking
        
        // check if a username has been previously taken
        require(userNameToAddress[_userName] == 0x0000000000000000000000000000000000000000, "This user name has been taken.");
        // make sure one address can only reginster one account 
        require( keccak256(abi.encodePacked(addressToUserInfo[msg.sender].userName)) == keccak256(abi.encodePacked("")), "One address can only create one account." );

        // push the created userinfo to the dataledger
        UserInfo memory newUser = UserInfo({
            userName: _userName,
            totalCostInEther: 0,
            isWinnerOfCurrentPool: false,
            winningAmountOfCurrentPool: 0
        }); 

        usersDataLedger.push(newUser);
        
        // update seraching maps
        userNameToAddress[_userName] = msg.sender;
        addressToUserInfo[msg.sender] = newUser;
        userNameToUserInfo[_userName] = newUser;
    }


    // let the address know its user information
    function checkMyUserInfo() external view validUser() returns(string memory, uint32, bool, uint256) { // changed from public to external
        
        return (addressToUserInfo[msg.sender].userName, 
                addressToUserInfo[msg.sender].totalCostInEther, 
                addressToUserInfo[msg.sender].isWinnerOfCurrentPool, 
                addressToUserInfo[msg.sender].winningAmountOfCurrentPool);
    }


    // This function finds the maxCost of users
    // for now, this function is mannually checking by the owner of the contract, later on this funciton can be automated(every week, every 24 hrs,...) 
    function findMaxCostInEtherAmongUsers() public view onlyOwner() returns(uint32) { // this function is acutally check for it does not change state of a block chain
        
        uint32 maxUserAmountInEther = 0;

        for (uint256 i = 0; i < usersDataLedger.length; i++) {
            if (usersDataLedger[i].totalCostInEther > maxUserAmountInEther){
                maxUserAmountInEther = usersDataLedger[i].totalCostInEther;
            }   
        }
    
        return maxUserAmountInEther;
    }


}