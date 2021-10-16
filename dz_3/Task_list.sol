pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract TaskList {

    struct Task
    {
          string name;
          uint32  timestart;
          bool done;
    }
    int8 key=1;
	mapping (int8 =>Task) map;

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

	
	function add_task(string name ) public checkOwnerAndAccept {
  
		map[key]=Task(name,now,false);
        key++;
	}
  
    function number_of_open_tasks() public checkOwnerAndAccept  returns (int8) {

        int8 counterTrue=0;
		for(int8 i=1;i<=key;i++)
        {
            if(map[i].done==true) counterTrue++;
        }
        return counterTrue;
	}
     function task_list() public checkOwnerAndAccept  returns (mapping (int8 =>Task)) {
         return map;
        
	}
     function get_description(int8 userkey)  public checkOwnerAndAccept  returns (string) {

       return map[userkey].name;
	}
      function delete_task(int8 userkey)  public checkOwnerAndAccept  {

        delete map[userkey];
	}
      function mark_task(int8 userkey)  public checkOwnerAndAccept  {

       map[userkey].done=true;
	}
}
