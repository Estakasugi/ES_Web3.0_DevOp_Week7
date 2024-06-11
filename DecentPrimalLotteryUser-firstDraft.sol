// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/*
    @author: ES_TAKASUGI
*/

contract DecentPrimalLotteryUser{

    uint lotteryTicketPrice = 0.0005 ether; // will move to the pool function

    // structure for user of the lottery
    struct UserInfo { 
        string userName;
        uint32 totalCost;   // change this to uint256, incase of using wei or Gwei, or keep it with ether and change it to totalCostInEther
        bool isWinnerOfCurrentPool;
        uint256 winningAmountOfCurrentPool;
    }


    // the data base is only interactable within the contracts and its heritage
    UserInfo[] internal usersDataLedger;


    // some mappings for searchings(some could be useless, we will see further down the road)
    // they are internal, we want only the address only able to interact with their own account(checking their user name or vise versa)
    // users are not allowed to check other users' address
    
    // TO-DO: simplify the mapping system
    mapping (address => string) internal addressToUserName;
    mapping (string => address) internal userNameToAddress;
    mapping (address => UserInfo) internal addressToUserInfo;
    // TO-DO: need to add a mapping to facilitate finding the max totalCost user  


    // This function modifier ensures that the calling address for certain functions 
    // belongs to the actual lottery user with whom the address is interacting.(buy ticket, withdraw rewards, etc.)
    // TO-DO: delete it and create a simpler logic
    modifier onlyAddressOf(string memory _userName) {
        require( msg.sender == userNameToAddress[_userName] );
        _;
    }

    // This function modifier ensures that the address has a valid user account in the lottery system
    modifier validUser() {
        // solidity does not allow string comp, this is the standard way to handle  string comparison
        require( keccak256(abi.encodePacked(addressToUserName[msg.sender])) != keccak256(abi.encodePacked("")), "User does not exist" ); 
        _;
    }


    // This function will create a UserInfo Struct and store it into usersDataLedger,
    // this function is interacable with functions/users/contracts outside of the contract
    function createUserInfo(string memory _userName) external  { // changed to external from public
        // TO-DO: Add user name legal/secure checking
        
        //check if a username has been previously taken
        require(userNameToAddress[_userName] == 0x0000000000000000000000000000000000000000, "This user name has been taken.");

        // push the created userinfo to the dataledger
        UserInfo memory newUser = UserInfo({
            userName: _userName,
            totalCost: 0,
            isWinnerOfCurrentPool: false,
            winningAmountOfCurrentPool: 0
        }); 

        usersDataLedger.push(newUser);
        
        // update seraching maps
        addressToUserName[msg.sender] = _userName;
        userNameToAddress[_userName] = msg.sender;
        addressToUserInfo[msg.sender] = newUser;
    }


    // let the address know its user name
    // TO-DO: make it that address know all of its user name
    function checkMyUserName() external view validUser() returns(string memory) { // changed from public to external
        
        return addressToUserInfo[msg.sender].userName;
    }



}
