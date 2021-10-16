pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract multiplication {

	
	uint256 public result = 1;

	constructor() public {
	
		require(tvm.pubkey() != 0, 101);
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

	


	function multiply(uint8 value) public  {
        require(msg.pubkey() == tvm.pubkey(), 102);
        require(value>=1 && value<=10, 103);//checking the boundaries of a number
        tvm.accept();
		result *= value;
	}
}