// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import  "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FlashChat  is ERC20{
    uint256 public totalServer;
    uint256 public totalMembers;

    address public creator;

constructor () ERC20("FlashToken","FT")
{
    owner = msg.sender;
}
    struct Server {
        uint256 id;
        string name;
        address owner;
        uint256 ft;
    }
    struct Member {
        address member;
        bool flag;
    }
    mapping(uint256 => Server) public servers;
    mapping(uint256 => Member) public joinedmembers;
    modifier onlyOwner() {
        require(msg.sender == creator, "not owner");
        _;
    }
  
    event Message(
        string name,
        string message,
        address indexed sender,
        address indexed receiver
    );

    function createServer(string memory _name, uint256 _ft) external onlyOwner {
        totalServer++;
        servers[totalServer] = Server(totalServer, _name, msg.sender, _ft);
    }
    function channelMembers(uint256 _id, string memory _name) external
    {

    }

    function sendMessage(
        uint _id,
        string memory _name,
        string memory _message,
        address _receiver
    ) external {
        require(joinedmembers[_id]==true,"not a member of channel");
        emit Message(_name, _message, msg.sender, _receiver);
    }
}