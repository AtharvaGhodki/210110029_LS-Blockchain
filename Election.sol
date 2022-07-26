pragma solidity ^0.8.7;
contract Election{
    struct Candidate{
       string name;
        uint vote_count;
    }
    struct Voter{
        bool voted;
        uint vote_index;
        uint weight;
    }
    address public owner;
    string public name;
    mapping(address=>Voter) public voters;
    Candidate[] candidates;
    uint public voting_end;
    event ElectionResult(string name,uint vote_count);
    function Election_Committee(string memory _name,uint duration_hours,string memory candidate_name_1,string memory candidate_name_2) public{
        owner=msg.sender;
        name=_name;
        voting_end=block.timestamp+ (duration_hours*1 hours);
        candidates.push(Candidate(candidate_name_1,0));
        candidates.push(Candidate(candidate_name_2,0));
    }
    function Authorization(address voter)public{
        require(msg.sender==owner);
        require(!voters[voter].voted);
        voters[voter].weight=1;
    }
    function vote(uint voteIndex) public{
        require(block.timestamp<voting_end);
        require(!voters[msg.sender].voted);
        voters[msg.sender].voted=true;
        voters[msg.sender].vote_index=voteIndex;
        candidates[voteIndex].vote_count +=voters[msg.sender].weight;
    }
    function end_election()public{
         require(msg.sender==owner);
         for(uint i=0;i<candidates.length;i++){
         emit ElectionResult(candidates[i].name,candidates[i].vote_count);
         }
    }

}