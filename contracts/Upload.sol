// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;
contract Upload{
    //unknown address=0xqwerty
    struct Access{//jis bhi user ke sath address share karna hoga wo access yaha se hi milega
        address user;//address of user who get the access from 0xqwerty
        bool access;//true or false
    }
    mapping(address=>string[])value;//to store image URL
    mapping(address=>mapping(address=>bool))ownership;//here one address giving access to another
    mapping(address=>Access[])accessList;
    mapping(address=>mapping(address=>bool))previousData;

    function add(address _user,string memory url)external{//for store image URL corresponding to user address
        value[_user].push(url);
    }

    function allow(address user)external{//it allows whether i have given access to other or not 
    ownership[msg.sender][user]=true;
    if(previousData[msg.sender][user])
    {
        for(uint i=0;i<accessList[msg.sender].length;i++)
        {
            if(accessList[msg.sender][i].user==user)
            {
                accessList[msg.sender][i].access=true;
            }
        }
    }
    else{
    accessList[msg.sender].push(Access(user,true));
    previousData[msg.sender][user]=true;
    }
}

    function disallow(address user)public{
        ownership[msg.sender][user]=false;
        for(uint i=0;i<accessList[msg.sender].length;i++)
        {
            if(accessList[msg.sender][i].user==user)
            {
                accessList[msg.sender][i].access=false;
            }
        }
    }


    function display(address _user)external view returns(string[] memory){//for Display images
        require(_user==msg.sender || ownership[_user][msg.sender],"You dont have access");
        return value[_user];
    }

    function shareAccess() public view returns(Access[] memory){//jinke sath bhi mane access share kiya hai unki list return hogi
        return accessList[msg.sender];
    }
}
