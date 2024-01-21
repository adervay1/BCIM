package BCIM_PKG;

    //class BCIM_class #(int DATA_WIDTH);
    class BCIM_class #(int ARRAY_WIDTH = 8, int BUS_DATA_WIDTH = 32);
        //Class Parameters
        localparam PIM_ADDR_BITS = 8;
        localparam LOAD_OFFSET = 2**PIM_ADDR_BITS;
    
        //Class Properties
        string my_name;
        string prgm;
        
        //Class Constructor
        function new(input string my_name, input string prgm);
            this.my_name    = my_name;
              
            case(prgm)
                "ECB_AES"   : this.prgm = prgm;
                "CTR_AES"   : this.prgm = prgm;
                "RECTANGLE" : this.prgm = prgm;
                "SIMON"     : this.prgm = prgm;
                default     : $display("ERROR: Constructor Program Arg Empty or Unrecognized (%s)",this.prgm);
            endcase
            
        endfunction
        
        //Testbench specific methods:
        virtual function Get_Memory_Array(input int addr, output logic [ARRAY_WIDTH-1:0] data);
            $display("ERROR: method 'Get_Memory_Array()' called from parent class on handle %s",this.my_name);
            data = 'x;
        endfunction
        
        virtual task Read_Memory_Array(input int read_addr, output logic [BUS_DATA_WIDTH-1:0] rdata);
            $display("ERROR: method 'Read_Memory_Array()' called from parent class on handle %s",this.my_name);
            rdata = 'x;
        endtask
        
        virtual task Send_IMC_Command(input logic [BUS_DATA_WIDTH-1:0] write_data);
            $display("ERROR: method 'Send_IMC_Command()' called from parent class on handle (%s)",this.my_name);
        endtask
        
        virtual task Write_Memory_Array(input int write_addr, input logic [BUS_DATA_WIDTH-1:0] write_data);
            $display("ERROR: method 'Write_Memory_Array()' called from parent class on handle (%s)",this.my_name);
        endtask
        
        //Common Methods
        task Load_IMC_Byte(input logic [7:0] byte_in, input int start_addr);

            $display("-- Loading %2h on WL %3h - %3h (%t)ps --",byte_in,start_addr,start_addr+7,$time);
            begin
                for (int i = 0; i < 8; i++) begin
                    this.Write_Memory_Array(start_addr+i+LOAD_OFFSET,byte_in[i]);
                end
            end
        endtask

        
        task Print_AES_State_Bytes_1Col(input int start_addr, string tag);
            logic [7:0] state_bytes [15:0];
            //When I tried to put this into an `include file, it was failing to recognize the parameter
            //Probably an issue with scope and `include compilation order so for now leave here.
            logic [BUS_DATA_WIDTH-1:0] rdata;
        
            
            for (int j = 0; j < 16; j++) begin
                for (int i = 0; i < 8; i++) begin
                    Read_Memory_Array((start_addr+(j*8)+i), rdata);
                    state_bytes[j][i] = rdata[0];
                end
            end
            $display("---------------------");
            $display("\t%S",tag);
            $display("---------------------");
            $display("| %H | %H | %H | %H |",state_bytes[0],state_bytes[4],state_bytes[8],state_bytes[12]);
            $display("---------------------");
            $display("| %H | %H | %H | %H |",state_bytes[1],state_bytes[5],state_bytes[9],state_bytes[13]);
            $display("---------------------");
            $display("| %H | %H | %H | %H |",state_bytes[2],state_bytes[6],state_bytes[10],state_bytes[14]);
            $display("---------------------");
            $display("| %H | %H | %H | %H |",state_bytes[3],state_bytes[7],state_bytes[11],state_bytes[15]);
            $display("---------------------");
            
        endtask

    
        //Definitions of Cipher routines(methods)
        `include "../ECB_AES/ECB_AES_methods.sv";
        `include "../CTR_AES/CTR_AES_methods.sv";
        `include "../RECTANGLE/RECTANGLE_methods.sv";
        `include "../SIMON/SIMON_methods.sv";


        //IMC Routines
        task Run_Cipher();
            case (this.prgm)
                "ECB_AES"   : this.test_ecb_aes();
                "CTR_AES"   : this.test_ctr_aes();
                "RECTANGLE" : this.test_rectangle();
                "SIMON"     : this.test_simon();
            endcase
        endtask
          
    endclass
endpackage