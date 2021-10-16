pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Queue {

	string[] public namePeople;

	constructor() public {
		// check that contract's public key is set
		require(tvm.pubkey() != 0, 101);
		// Check that message has signature (msg.pubkey() is not zero) and message is signed with the owner's private key
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

	
	modifier checkOwnerAndAccept {
		// Check that message was signed with contracts key.
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

	
	function get_in_line(string name ) public checkOwnerAndAccept {
		namePeople.push(name);
	}
    function call_the_next_one() public checkOwnerAndAccept {
		require(!namePeople.empty(),103) ;//array is empty
        for(uint i=0;i<namePeople.length-1;i++)
        {
            namePeople[i]=namePeople[i+1];
        }
        namePeople.pop();
	}
}