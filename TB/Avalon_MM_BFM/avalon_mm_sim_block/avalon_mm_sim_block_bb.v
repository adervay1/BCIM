
module avalon_mm_sim_block (
	clk,
	reset,
	avm_address,
	avm_readdata,
	avm_writedata,
	avm_waitrequest,
	avm_write,
	avm_read,
	avm_readdatavalid);	

	input		clk;
	input		reset;
	output	[31:0]	avm_address;
	input	[31:0]	avm_readdata;
	output	[31:0]	avm_writedata;
	input		avm_waitrequest;
	output		avm_write;
	output		avm_read;
	input		avm_readdatavalid;
endmodule
