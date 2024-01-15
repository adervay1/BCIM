package BCIM_PKG;

    //class BCIM_class #(int DATA_WIDTH);
    class BCIM_class #(int ARRAY_WIDTH = 8, int BUS_DATA_WIDTH = 32);
    
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
        virtual function get_memory_array(input int addr, output [ARRAY_WIDTH-1:0] data);
            $display("ERROR: method 'get_memory_array()' called from parent class on handle %s",this.my_name);
            data = 'x;
        endfunction
        
        virtual task read_memory_array(input int read_addr, output [ARRAY_WIDTH-1:0] rdata);
            $display("ERROR: method 'read_memory_array()' called from parent class on handle %s",this.my_name);
            rdata = 'x;
        endtask
        
        virtual task send_imc_command(input [BUS_DATA_WIDTH-1:0] write_data);
            $display("ERROR: method 'send_imc_command()' called from parent class on handle (%s)",this.my_name);
        endtask
    
    
        //Definitions of Cipher routines(methods)
        `include "../ECB_AES/ECB_AES_methods.sv";
        `include "../CTR_AES/CTR_AES_methods.sv";
        `include "../RECTANGLE/RECTANGLE_methods.sv";
        `include "../SIMON/SIMON_methods.sv";


        //IMC Routines
        task run_cipher();
            case (this.prgm)
                "ECB_AES"   : this.test_ecb_aes();
                "CTR_AES"   : this.test_ctr_aes();
                "RECTANGLE" : this.test_rectangle();
                "SIMON"     : this.test_simon();
            endcase
        endtask
        
        
        
        task test_case_access(input int addr);
            logic [ARRAY_WIDTH-1:0] data;
            this.get_memory_array(addr,data);
            $display("Data: %h", data);
            
            this.read_memory_array(addr,data);
            $display("Data: %h", data);
        endtask
        
        task test_write_sequence();

            this.send_imc_command(32'd83918848);
            this.send_imc_command(32'd83984641);
            this.send_imc_command(32'd84050434);
            this.send_imc_command(32'd84116227);
            this.send_imc_command(32'd84182020);
            this.send_imc_command(32'd84247813);
            this.send_imc_command(32'd84313606);
            this.send_imc_command(32'd84379399);
            this.send_imc_command(32'd84445192);
            this.send_imc_command(32'd84510985);
            this.send_imc_command(32'd84576778);
            this.send_imc_command(32'd84642571);
            this.send_imc_command(32'd84708364);
            this.send_imc_command(32'd84774157);
            this.send_imc_command(32'd84839950);
            this.send_imc_command(32'd84905743);
            this.send_imc_command(32'd84971536);
            this.send_imc_command(32'd85037329);
            this.send_imc_command(32'd85103122);
            this.send_imc_command(32'd85168915);
            this.send_imc_command(32'd85234708);
            this.send_imc_command(32'd85300501);
            this.send_imc_command(32'd85366294);
            this.send_imc_command(32'd85432087);
            this.send_imc_command(32'd85497880);
            this.send_imc_command(32'd85563673);
            this.send_imc_command(32'd85629466);
            this.send_imc_command(32'd85695259);
            this.send_imc_command(32'd85761052);
            this.send_imc_command(32'd85826845);
            this.send_imc_command(32'd85892638);
            this.send_imc_command(32'd85958431);
            this.send_imc_command(32'd86024224);
            this.send_imc_command(32'd86090017);
            this.send_imc_command(32'd86155810);
            this.send_imc_command(32'd86221603);
            this.send_imc_command(32'd86287396);
            this.send_imc_command(32'd86353189);
            this.send_imc_command(32'd86418982);
            this.send_imc_command(32'd86484775);
            this.send_imc_command(32'd86550568);
            this.send_imc_command(32'd86616361);
            this.send_imc_command(32'd86682154);
            this.send_imc_command(32'd86747947);
            this.send_imc_command(32'd86813740);
            this.send_imc_command(32'd86879533);
            this.send_imc_command(32'd86945326);
            this.send_imc_command(32'd87011119);
            this.send_imc_command(32'd87076912);
            this.send_imc_command(32'd87142705);
            this.send_imc_command(32'd87208498);
            this.send_imc_command(32'd87274291);
            this.send_imc_command(32'd87340084);
            this.send_imc_command(32'd87405877);
            this.send_imc_command(32'd87471670);
            this.send_imc_command(32'd87537463);
            this.send_imc_command(32'd87603256);
            this.send_imc_command(32'd87669049);
            this.send_imc_command(32'd87734842);
            this.send_imc_command(32'd87800635);
            this.send_imc_command(32'd87866428);
            this.send_imc_command(32'd87932221);
            this.send_imc_command(32'd87998014);
            this.send_imc_command(32'd88063807);
            this.send_imc_command(32'd88129600);
            this.send_imc_command(32'd88195393);
            this.send_imc_command(32'd88261186);
            this.send_imc_command(32'd88326979);
            this.send_imc_command(32'd88392772);
            this.send_imc_command(32'd88458565);
            this.send_imc_command(32'd88524358);
            this.send_imc_command(32'd88590151);
            this.send_imc_command(32'd88655944);
            this.send_imc_command(32'd88721737);
            this.send_imc_command(32'd88787530);
            this.send_imc_command(32'd88853323);
            this.send_imc_command(32'd88919116);
            this.send_imc_command(32'd88984909);
            this.send_imc_command(32'd89050702);
            this.send_imc_command(32'd89116495);
            this.send_imc_command(32'd89182288);
            this.send_imc_command(32'd89248081);
            this.send_imc_command(32'd89313874);
            this.send_imc_command(32'd89379667);
            this.send_imc_command(32'd89445460);
            this.send_imc_command(32'd89511253);
            this.send_imc_command(32'd89577046);
            this.send_imc_command(32'd89642839);
            this.send_imc_command(32'd89708632);
            this.send_imc_command(32'd89774425);
            this.send_imc_command(32'd89840218);
            this.send_imc_command(32'd89906011);
            this.send_imc_command(32'd89971804);
            this.send_imc_command(32'd90037597);
            this.send_imc_command(32'd90103390);
            this.send_imc_command(32'd90169183);
            this.send_imc_command(32'd90234976);
            this.send_imc_command(32'd90300769);
            this.send_imc_command(32'd90366562);
            this.send_imc_command(32'd90432355);
            this.send_imc_command(32'd90498148);
            this.send_imc_command(32'd90563941);
            this.send_imc_command(32'd90629734);
            this.send_imc_command(32'd90695527);
            this.send_imc_command(32'd90761320);
            this.send_imc_command(32'd90827113);
            this.send_imc_command(32'd90892906);
            this.send_imc_command(32'd90958699);
            this.send_imc_command(32'd91024492);
            this.send_imc_command(32'd91090285);
            this.send_imc_command(32'd91156078);
            this.send_imc_command(32'd91221871);
            this.send_imc_command(32'd91287664);
            this.send_imc_command(32'd91353457);
            this.send_imc_command(32'd91419250);
            this.send_imc_command(32'd91485043);
            this.send_imc_command(32'd91550836);
            this.send_imc_command(32'd91616629);
            this.send_imc_command(32'd91682422);
            this.send_imc_command(32'd91748215);
            this.send_imc_command(32'd91814008);
            this.send_imc_command(32'd91879801);
            this.send_imc_command(32'd91945594);
            this.send_imc_command(32'd92011387);
            this.send_imc_command(32'd92077180);
            this.send_imc_command(32'd92142973);
            this.send_imc_command(32'd92208766);
            this.send_imc_command(32'd92274559);
            
        endtask
        
    endclass
endpackage