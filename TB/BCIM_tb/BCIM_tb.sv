`timescale 1ns/1ps

module BCIM_tb;

import avalon_mm_pkg::*;
import verbosity_pkg::*;

import BCIM_PKG::*;

//-----------------------------------------------------------------------------------------------------------------
//                                              DUT
//-----------------------------------------------------------------------------------------------------------------

logic clk;
logic rst;

logic [7:0] stimulus;

logic [31:0] avalon_mm_addr;

logic [31:0] avalon_mm_wdata;
logic [31:0] avalon_mm_rdata;

logic       avalon_mm_waitreq, avalon_mm_readdatavalid, avalon_mm_read, avalon_mm_write;


avalon_mm_sim_block avalon_mm_sim_block_inst (
    .clk               (clk), // clk.clk
    .reset             (rst), // clk_reset.reset
    .avm_address       (avalon_mm_addr), // m0.address
    .avm_readdata      (avalon_mm_rdata), // .readdata
    .avm_writedata     (avalon_mm_wdata), // .writedata
    .avm_waitrequest   (avalon_mm_waitreq), // .waitrequest
    .avm_write         (avalon_mm_write), // .write
    .avm_read          (avalon_mm_read), // .read
    .avm_readdatavalid (avalon_mm_readdatavalid) // .readdatavalid
);



prime_datapath prime_datapath_inst (
    .sys_clk_in                 (clk),
    .sys_reset_in               (rst),

    //IMC Main Master
    .IMC_mm_waitrequest_out     (avalon_mm_waitreq),
    .IMC_mm_readdata_out        (avalon_mm_rdata),
    .IMC_mm_readdatavalid_out   (avalon_mm_readdatavalid),

    .IMC_mm_writedata_in        (avalon_mm_wdata),
    .IMC_mm_address_in          (avalon_mm_addr[8:0]),
    .IMC_mm_write_in            (avalon_mm_write),
    .IMC_mm_read_in             (avalon_mm_read)
);


//-----------------------------------------------------------------------------------------------------------------
//                                              Class Extension
//-----------------------------------------------------------------------------------------------------------------


class tb_BCIM_class #(
    int ARRAY_WIDTH = 8, 
    int BUS_DATA_WIDTH
) extends BCIM_class#(
    .ARRAY_WIDTH(ARRAY_WIDTH),
    .BUS_DATA_WIDTH(BUS_DATA_WIDTH)
);

    function new(input string my_name, input string prgm);
        super.new(my_name, prgm);
    endfunction
    
    //"Harness" connecting virtual function from parent to TB implementation details
    function Get_Memory_Array(input int addr, output logic [ARRAY_WIDTH-1:0] data);
        data = prime_datapath_inst.ram_model_inst.mem[addr];
    endfunction
    
    //"Harness" connecting virtual function from parent to TB implementation details
    // This task operates the bfm to read IMC data
    task Read_Memory_Array(input int read_addr, output logic [BUS_DATA_WIDTH-1:0] rdata);
    
        avalon_mm_sim_block_inst.mm_master_bfm_0.set_command_address(read_addr);
        avalon_mm_sim_block_inst.mm_master_bfm_0.set_command_request(REQ_READ);
        
        avalon_mm_sim_block_inst.mm_master_bfm_0.push_command();
    
        @(negedge(avalon_mm_readdatavalid));
        
        avalon_mm_sim_block_inst.mm_master_bfm_0.pop_response();
        rdata = avalon_mm_sim_block_inst.mm_master_bfm_0.get_response_data(0);
    
    endtask
    
    //"Harness" connecting virtual function from parent to TB implementation details
    // This task operates the bfm to send IMC commands. Writes on this bus are intrepreted as IMC unless the upper address bit is set
    task Send_IMC_Command(input logic [BUS_DATA_WIDTH-1:0] write_data);

        avalon_mm_sim_block_inst.mm_master_bfm_0.set_command_data(write_data,0); // Set index to zero for now
        avalon_mm_sim_block_inst.mm_master_bfm_0.set_command_address(0);
        avalon_mm_sim_block_inst.mm_master_bfm_0.set_command_request(REQ_WRITE);
    
        avalon_mm_sim_block_inst.mm_master_bfm_0.push_command();
        
        @(negedge(avalon_mm_write));
        avalon_mm_sim_block_inst.mm_master_bfm_0.pop_response();
        
        wait(prime_datapath_inst.rw_control_inst.state == 8'h1F);
        
    endtask
    
    //"Harness" connecting virtual function from parent to TB implementation details
    // This task operates the bfm to send generic write commands. Array is addressed by setting address MSB and settings LSB accordingly
    task Write_Memory_Array(input int write_addr, input logic [BUS_DATA_WIDTH-1:0] write_data);
        begin
            //$display("-- Sending Write Command (%t)ps --",$time);
            avalon_mm_sim_block_inst.mm_master_bfm_0.set_command_data(write_data,0); // Set index to zero for now
            avalon_mm_sim_block_inst.mm_master_bfm_0.set_command_address(write_addr);
            avalon_mm_sim_block_inst.mm_master_bfm_0.set_command_request(REQ_WRITE);
        
            avalon_mm_sim_block_inst.mm_master_bfm_0.push_command();
            
            @(negedge(avalon_mm_write));
            avalon_mm_sim_block_inst.mm_master_bfm_0.pop_response();
        end
    endtask

endclass

tb_BCIM_class#(32,32) env_cipher_obj;



//-----------------------------------------------------------------------------------------------------------------
//                                              Stimulus
//-----------------------------------------------------------------------------------------------------------------

initial begin
    rst = 1'b1;
    $display("-- Simulation Starting (%t)ps --",$time);
    
    //verbosity_pkg::set_verbosity(VERBOSITY_DEBUG);
    
    #1us;
    rst = 1'b0;
    #1us;
    
    
    //set_command
    
    //Init BFM
    $display("Version %S",avalon_mm_sim_block_inst.mm_master_bfm_0.get_version());
    avalon_mm_sim_block_inst.mm_master_bfm_0.init();

    //Construct Cipher Object
    env_cipher_obj = new("ECB_AES_child", "ECB_AES");
    
    env_cipher_obj.AES_ECB_Encrypt();
    env_cipher_obj.AES_ECB_Decrypt();


    #128000;

    $display("-- Simulation Completed (%t)ps --",$time);
    $stop;
    #100;
end


initial begin
    clk = 1'b0;
    forever #42 clk = ~clk;

end

//-----------------------------------------------------------------------------------------------------------------
//                                              Tasks
//-----------------------------------------------------------------------------------------------------------------


endmodule