	avalon_mm_sim_block u0 (
		.clk               (<connected-to-clk>),               //       clk.clk
		.reset             (<connected-to-reset>),             // clk_reset.reset
		.avm_address       (<connected-to-avm_address>),       //        m0.address
		.avm_readdata      (<connected-to-avm_readdata>),      //          .readdata
		.avm_writedata     (<connected-to-avm_writedata>),     //          .writedata
		.avm_waitrequest   (<connected-to-avm_waitrequest>),   //          .waitrequest
		.avm_write         (<connected-to-avm_write>),         //          .write
		.avm_read          (<connected-to-avm_read>),          //          .read
		.avm_readdatavalid (<connected-to-avm_readdatavalid>)  //          .readdatavalid
	);

