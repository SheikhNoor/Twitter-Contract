// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 < 0.9.0;

contract Twitter{
    struct Tweet{
        uint id;
        address author;
        string content;
        uint createAt;

    }

    struct Message{
        uint id;
        string content;
        address from;
        address to;
        uint createAt;
    }

    mapping (uint => Tweet) public tweets;
    mapping (address => uint[]) public tweetsOf;
    mapping (address => Message[]) public conversation;
    mapping (address=> mapping (address=>bool)) public  operators;
    mapping (address=>address[]) public following;

    uint nextId;
    uint nextMessageId;

    function _tweet(address _from, string memory _content) public {
        tweets[nextId] = Tweet(nextId ,_from ,_content, block.timestamp);
        nextId = nextId+1;

    }

    function _sendMessage(address _from,address _to, string memory _content) public{
        conversation[_from].push(Message(nextMessageId, _content,_from,_to,block.timestamp));
        nextMessageId++;
    }

    function tweet(string memory _content) public {
        _tweet(msg.sender, _content);
    }

    function tweet(address _from,string memory _content) public{
        _tweet(_from,_content);
    }

    function sendMessage(string memory _content,address _to) public {
        _sendMessage(msg.sender,  _to ,   _content ); 
    }

    function sendMessage(address _from,address _to, string memory _content) public {
        _sendMessage(_from, _to, _content);
    }
        
    function follow(address _followed) public{
        following[msg.sender].push(_followed);
    }

    // function unfollow(address _followed) public{
    //     following[msg.sender].remove(_followed);
    // }

    function allow(address _operator) public {
        operators[msg.sender][_operator] = true;
    }

    function disallow(address _operator) public{
        operators[msg.sender][_operator] = false;
    }

    function getLatestTweets(uint count) public returns(Tweet[] memory){
        require(count>0 && count<=nextId, "Count id not proper");
        Tweet[] memory _tweets = new Tweet[] (count);
        uint j;
        for (uint i = nextId-count;i<=nextId;nextId++){
            Tweet storage _structure = tweets[i];
            _tweets[j] =Tweet( _structure.id, _structure.author,_structure.content,_structure.createAt);
            j++;
        }

        return _tweets;
    }

    function getLetestTOUser(address _user, uint count) public view returns(Tweet[] memory) {
        Tweet [] memory _tweets = new Tweet[] (count);
        //tweetsOf[_user];
        require(count > 0 && count <= nextId, "Count is not defined");
        uint j ;
        for (uint i = tweetsOf[_user].length-count; i< tweetsOf[_user].length ; i++){
            Tweet storage _structure = tweets[i];
            _tweets[j] = Tweet(_structure.id,_structure.author, _structure.content, _structure.createAt);
            j=j+1;
        }
        return _tweets;
    }

}