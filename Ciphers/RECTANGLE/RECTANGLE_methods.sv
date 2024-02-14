task RECTANGLE_Demo(output logic passed);
    //This demonstates the RECTANGLE 80 Cipher using test pattern provided in paper. 
    //As such it only passes with the hardcoded plain text, predicted and key values
    logic [15:0] plain_text [3:0];   
    logic [15:0] init_key [4:0];
    logic [15:0] cipher_text [3:0];
    logic [15:0] predicted [3:0];
    logic [15:0] round_keys [25:0][3:0];
    
    init_key    = '{16'h0000,
                    16'h0000,
                    16'h0000,
                    16'h0000,
                    16'h0000};
                    
    REC_Key_Expansion(init_key, round_keys);
                            
                            
                            
    plain_text  = '{16'h0000,   //Row 0
                    16'h0000,
                    16'h0000,
                    16'h0000};  //Row 3
    
    predicted   = '{16'h0874,   //Row 0
                    16'hE8B1,
                    16'hE354,
                    16'h2D96};  //Row 3
                            
    
    
    Load_REC_State_1Col(plain_text,'h40);
    Print_REC_State_Bytes_1Col('h40, "PlainText");
    
    for (int rnd = 0; rnd < 25; rnd++) begin
        //Load Round Key
        Load_REC_State_1Col(round_keys[rnd],'h00);
        Print_REC_State_Bytes_1Col('h00, $sformatf("Round Key %2d",rnd));
        
        //Add Round Key
        REC_ARK();
        Print_REC_State_Bytes_1Col('h00, $sformatf("ARK %2d",rnd));
        
        //Col SBOX
        REC_Col_SBOX();
        Print_REC_State_Bytes_1Col('h40, $sformatf("Round State %2d",rnd));
    
    end
    
    //Final Round Key and ARK
    Load_REC_State_1Col(round_keys[25],'h00);
    Print_REC_State_Bytes_1Col('h00, $sformatf("Round Key %2d",25));
    
    REC_ARK();
    
    Print_REC_State_Bytes_1Col('h00, $sformatf("Cipher Text %2d",25));
          
    Get_REC_State_Bytes_1Col('h00, cipher_text);
    
    passed = (cipher_text == predicted);
    
endtask

//RECTANGLE Functions
function REC_Key_Expansion(input logic [15:0] init_key [4:0], output logic [15:0] round_keys [25:0][3:0]);
    //                                 x =   15,  14,  ....                                                              0
    static logic [3:0] SBOX_LUT [15:0] = '{4'h2,4'h4,4'hF,4'h8,4'hD,4'h3,4'h0,4'hB,4'h9,4'h7,4'hE,4'h1,4'hA,4'hC,4'h5,4'h6};
    
    static logic [4:0] RC_LUT [0:24] = '{5'h01, 5'h02, 5'h04, 5'h09, 5'h12, 5'h05,5'h0B, 5'h16, 5'h0C, 5'h19, 5'h13, 5'h07,5'h0F, 5'h1F, 5'h1E, 5'h1C, 5'h18, 5'h11,5'h03, 5'h06, 5'h0D, 5'h1B, 5'h17, 5'h0E, 5'h1D};
    
    logic [15:0] sub_key_reg [4:0];
    logic [15:0] temp_key_reg [4:0];
    
    logic [3:0] sbox0, sbox1, sbox2, sbox3;
    
    round_keys[0] = temp_key_reg[3:0];
    temp_key_reg = init_key;
    
    for (int i = 0; i < 25; i++) begin
        sub_key_reg = temp_key_reg;
        //Substitution Calculations
        //                              row3              row2              row1                row0
        sbox0 = SBOX_LUT[{temp_key_reg[3][0],temp_key_reg[2][0],temp_key_reg[1][0],temp_key_reg[0][0]}];
        sbox1 = SBOX_LUT[{temp_key_reg[3][1],temp_key_reg[2][1],temp_key_reg[1][1],temp_key_reg[0][1]}];
        sbox2 = SBOX_LUT[{temp_key_reg[3][2],temp_key_reg[2][2],temp_key_reg[1][2],temp_key_reg[0][2]}];
        sbox3 = SBOX_LUT[{temp_key_reg[3][3],temp_key_reg[2][3],temp_key_reg[1][3],temp_key_reg[0][3]}];
        
        //Substitution Assignments
        sub_key_reg[0][0] = sbox0[0];
        sub_key_reg[1][0] = sbox0[1];
        sub_key_reg[2][0] = sbox0[2];
        sub_key_reg[3][0] = sbox0[3];
        
        sub_key_reg[0][1] = sbox1[0];
        sub_key_reg[1][1] = sbox1[1];
        sub_key_reg[2][1] = sbox1[2];
        sub_key_reg[3][1] = sbox1[3];
        
        sub_key_reg[0][2] = sbox2[0];
        sub_key_reg[1][2] = sbox2[1];
        sub_key_reg[2][2] = sbox2[2];
        sub_key_reg[3][2] = sbox2[3];
        
        sub_key_reg[0][3] = sbox3[0];
        sub_key_reg[1][3] = sbox3[1];
        sub_key_reg[2][3] = sbox3[2];
        sub_key_reg[3][3] = sbox3[3];
        
        //Feistel Transformation
        //                  Circular Shift 8 left
        temp_key_reg[0] = {sub_key_reg[0][7:0],sub_key_reg[0][15:8]} ^ sub_key_reg[1];
        
        temp_key_reg[1] = sub_key_reg[2];
        
        temp_key_reg[2] = sub_key_reg[3];
    
        //                  Circular Shift 12 left
        temp_key_reg[3] = {sub_key_reg[3][3:0],sub_key_reg[3][15:4]} ^ sub_key_reg[4];
        
        temp_key_reg[4] = sub_key_reg[0];
        
        //XOR with round constants
        temp_key_reg[0][4:0] = temp_key_reg[0][4:0] ^ RC_LUT[i];
        
        //Assign 4 rows for key register to round index
        round_keys[i+1] = temp_key_reg[3:0];
    end

endfunction

//Common / Utility

task Load_REC_State_1Col(input logic [15:0] byte_in [3:0], input int start_addr);
    
    Load_IMC_Byte(byte_in[0][7:0],start_addr+'h0);
    Load_IMC_Byte(byte_in[0][15:8],start_addr+'h8);
    
    Load_IMC_Byte(byte_in[1][7:0],start_addr+'h10);
    Load_IMC_Byte(byte_in[1][15:8],start_addr+'h18);
    
    Load_IMC_Byte(byte_in[2][7:0],start_addr+'h20);
    Load_IMC_Byte(byte_in[2][15:8],start_addr+'h28);
    
    Load_IMC_Byte(byte_in[3][7:0],start_addr+'h30);
    Load_IMC_Byte(byte_in[3][15:8],start_addr+'h38);
    
endtask : Load_REC_State_1Col


//Round Functions

task REC_ARK();

    Send_IMC_Command(32'd88080384);
    Send_IMC_Command(32'd88146177);
    Send_IMC_Command(32'd88211970);
    Send_IMC_Command(32'd88277763);
    Send_IMC_Command(32'd88343556);
    Send_IMC_Command(32'd88409349);
    Send_IMC_Command(32'd88475142);
    Send_IMC_Command(32'd88540935);
    Send_IMC_Command(32'd88606728);
    Send_IMC_Command(32'd88672521);
    Send_IMC_Command(32'd88738314);
    Send_IMC_Command(32'd88804107);
    Send_IMC_Command(32'd88869900);
    Send_IMC_Command(32'd88935693);
    Send_IMC_Command(32'd89001486);
    Send_IMC_Command(32'd89067279);
    Send_IMC_Command(32'd89133072);
    Send_IMC_Command(32'd89198865);
    Send_IMC_Command(32'd89264658);
    Send_IMC_Command(32'd89330451);
    Send_IMC_Command(32'd89396244);
    Send_IMC_Command(32'd89462037);
    Send_IMC_Command(32'd89527830);
    Send_IMC_Command(32'd89593623);
    Send_IMC_Command(32'd89659416);
    Send_IMC_Command(32'd89725209);
    Send_IMC_Command(32'd89791002);
    Send_IMC_Command(32'd89856795);
    Send_IMC_Command(32'd89922588);
    Send_IMC_Command(32'd89988381);
    Send_IMC_Command(32'd90054174);
    Send_IMC_Command(32'd90119967);
    Send_IMC_Command(32'd90185760);
    Send_IMC_Command(32'd90251553);
    Send_IMC_Command(32'd90317346);
    Send_IMC_Command(32'd90383139);
    Send_IMC_Command(32'd90448932);
    Send_IMC_Command(32'd90514725);
    Send_IMC_Command(32'd90580518);
    Send_IMC_Command(32'd90646311);
    Send_IMC_Command(32'd90712104);
    Send_IMC_Command(32'd90777897);
    Send_IMC_Command(32'd90843690);
    Send_IMC_Command(32'd90909483);
    Send_IMC_Command(32'd90975276);
    Send_IMC_Command(32'd91041069);
    Send_IMC_Command(32'd91106862);
    Send_IMC_Command(32'd91172655);
    Send_IMC_Command(32'd91238448);
    Send_IMC_Command(32'd91304241);
    Send_IMC_Command(32'd91370034);
    Send_IMC_Command(32'd91435827);
    Send_IMC_Command(32'd91501620);
    Send_IMC_Command(32'd91567413);
    Send_IMC_Command(32'd91633206);
    Send_IMC_Command(32'd91698999);
    Send_IMC_Command(32'd91764792);
    Send_IMC_Command(32'd91830585);
    Send_IMC_Command(32'd91896378);
    Send_IMC_Command(32'd91962171);
    Send_IMC_Command(32'd92027964);
    Send_IMC_Command(32'd92093757);
    Send_IMC_Command(32'd92159550);
    Send_IMC_Command(32'd92225343);

endtask : REC_ARK

task REC_Col_SBOX();

    Send_IMC_Command(32'd235962368);
    Send_IMC_Command(32'd85995649);
    Send_IMC_Command(32'd84942978);
    Send_IMC_Command(32'd67141763);
    Send_IMC_Command(32'd53510276);
    Send_IMC_Command(32'd92504384);
    Send_IMC_Command(32'd83920005);
    Send_IMC_Command(32'd86017361);
    Send_IMC_Command(32'd75597190);
    Send_IMC_Command(32'd54559367);
    Send_IMC_Command(32'd92440189);
    Send_IMC_Command(32'd92637036);
    Send_IMC_Command(32'd236027904);
    Send_IMC_Command(32'd86061441);
    Send_IMC_Command(32'd85008770);
    Send_IMC_Command(32'd67207299);
    Send_IMC_Command(32'd53575812);
    Send_IMC_Command(32'd92504385);
    Send_IMC_Command(32'd83985541);
    Send_IMC_Command(32'd86082898);
    Send_IMC_Command(32'd75597190);
    Send_IMC_Command(32'd54624903);
    Send_IMC_Command(32'd92440190);
    Send_IMC_Command(32'd92637037);
    Send_IMC_Command(32'd236093440);
    Send_IMC_Command(32'd86127233);
    Send_IMC_Command(32'd85074562);
    Send_IMC_Command(32'd67272835);
    Send_IMC_Command(32'd53641348);
    Send_IMC_Command(32'd92504386);
    Send_IMC_Command(32'd84051077);
    Send_IMC_Command(32'd86148435);
    Send_IMC_Command(32'd75597190);
    Send_IMC_Command(32'd54690439);
    Send_IMC_Command(32'd92440191);
    Send_IMC_Command(32'd92637038);
    Send_IMC_Command(32'd236158976);
    Send_IMC_Command(32'd86193025);
    Send_IMC_Command(32'd85140354);
    Send_IMC_Command(32'd67338371);
    Send_IMC_Command(32'd53706884);
    Send_IMC_Command(32'd92504387);
    Send_IMC_Command(32'd84116613);
    Send_IMC_Command(32'd86213972);
    Send_IMC_Command(32'd75597190);
    Send_IMC_Command(32'd54755975);
    Send_IMC_Command(32'd92440176);
    Send_IMC_Command(32'd92637039);
    Send_IMC_Command(32'd236224512);
    Send_IMC_Command(32'd86258817);
    Send_IMC_Command(32'd85206146);
    Send_IMC_Command(32'd67403907);
    Send_IMC_Command(32'd53772420);
    Send_IMC_Command(32'd92504388);
    Send_IMC_Command(32'd84182149);
    Send_IMC_Command(32'd86279509);
    Send_IMC_Command(32'd75597190);
    Send_IMC_Command(32'd54821511);
    Send_IMC_Command(32'd92440177);
    Send_IMC_Command(32'd92637024);
    Send_IMC_Command(32'd236290048);
    Send_IMC_Command(32'd86324609);
    Send_IMC_Command(32'd85271938);
    Send_IMC_Command(32'd67469443);
    Send_IMC_Command(32'd53837956);
    Send_IMC_Command(32'd92504389);
    Send_IMC_Command(32'd84247685);
    Send_IMC_Command(32'd86345046);
    Send_IMC_Command(32'd75597190);
    Send_IMC_Command(32'd54887047);
    Send_IMC_Command(32'd92440178);
    Send_IMC_Command(32'd92637025);
    Send_IMC_Command(32'd236355584);
    Send_IMC_Command(32'd86390401);
    Send_IMC_Command(32'd85337730);
    Send_IMC_Command(32'd67534979);
    Send_IMC_Command(32'd53903492);
    Send_IMC_Command(32'd92504390);
    Send_IMC_Command(32'd84313221);
    Send_IMC_Command(32'd86410583);
    Send_IMC_Command(32'd75597190);
    Send_IMC_Command(32'd54952583);
    Send_IMC_Command(32'd92440179);
    Send_IMC_Command(32'd92637026);
    Send_IMC_Command(32'd236421120);
    Send_IMC_Command(32'd86456193);
    Send_IMC_Command(32'd85403522);
    Send_IMC_Command(32'd67600515);
    Send_IMC_Command(32'd53969028);
    Send_IMC_Command(32'd92504391);
    Send_IMC_Command(32'd84378757);
    Send_IMC_Command(32'd86476120);
    Send_IMC_Command(32'd75597190);
    Send_IMC_Command(32'd55018119);
    Send_IMC_Command(32'd92440180);
    Send_IMC_Command(32'd92637027);
    Send_IMC_Command(32'd236486656);
    Send_IMC_Command(32'd86521985);
    Send_IMC_Command(32'd85469314);
    Send_IMC_Command(32'd67666051);
    Send_IMC_Command(32'd54034564);
    Send_IMC_Command(32'd92504392);
    Send_IMC_Command(32'd84444293);
    Send_IMC_Command(32'd86541657);
    Send_IMC_Command(32'd75597190);
    Send_IMC_Command(32'd55083655);
    Send_IMC_Command(32'd92440181);
    Send_IMC_Command(32'd92637028);
    Send_IMC_Command(32'd236552192);
    Send_IMC_Command(32'd86587777);
    Send_IMC_Command(32'd85535106);
    Send_IMC_Command(32'd67731587);
    Send_IMC_Command(32'd54100100);
    Send_IMC_Command(32'd92504393);
    Send_IMC_Command(32'd84509829);
    Send_IMC_Command(32'd86607194);
    Send_IMC_Command(32'd75597190);
    Send_IMC_Command(32'd55149191);
    Send_IMC_Command(32'd92440182);
    Send_IMC_Command(32'd92637029);
    Send_IMC_Command(32'd236617728);
    Send_IMC_Command(32'd86653569);
    Send_IMC_Command(32'd85600898);
    Send_IMC_Command(32'd67797123);
    Send_IMC_Command(32'd54165636);
    Send_IMC_Command(32'd92504394);
    Send_IMC_Command(32'd84575365);
    Send_IMC_Command(32'd86672731);
    Send_IMC_Command(32'd75597190);
    Send_IMC_Command(32'd55214727);
    Send_IMC_Command(32'd92440183);
    Send_IMC_Command(32'd92637030);
    Send_IMC_Command(32'd236683264);
    Send_IMC_Command(32'd86719361);
    Send_IMC_Command(32'd85666690);
    Send_IMC_Command(32'd67862659);
    Send_IMC_Command(32'd54231172);
    Send_IMC_Command(32'd92504395);
    Send_IMC_Command(32'd84640901);
    Send_IMC_Command(32'd86738268);
    Send_IMC_Command(32'd75597190);
    Send_IMC_Command(32'd55280263);
    Send_IMC_Command(32'd92440184);
    Send_IMC_Command(32'd92637031);
    Send_IMC_Command(32'd236748800);
    Send_IMC_Command(32'd86785153);
    Send_IMC_Command(32'd85732482);
    Send_IMC_Command(32'd67928195);
    Send_IMC_Command(32'd54296708);
    Send_IMC_Command(32'd92504396);
    Send_IMC_Command(32'd84706437);
    Send_IMC_Command(32'd86803805);
    Send_IMC_Command(32'd75597190);
    Send_IMC_Command(32'd55345799);
    Send_IMC_Command(32'd92440185);
    Send_IMC_Command(32'd92637032);
    Send_IMC_Command(32'd236814336);
    Send_IMC_Command(32'd86850945);
    Send_IMC_Command(32'd85798274);
    Send_IMC_Command(32'd67993731);
    Send_IMC_Command(32'd54362244);
    Send_IMC_Command(32'd92504397);
    Send_IMC_Command(32'd84771973);
    Send_IMC_Command(32'd86869342);
    Send_IMC_Command(32'd75597190);
    Send_IMC_Command(32'd55411335);
    Send_IMC_Command(32'd92440186);
    Send_IMC_Command(32'd92637033);
    Send_IMC_Command(32'd236879872);
    Send_IMC_Command(32'd86916737);
    Send_IMC_Command(32'd85864066);
    Send_IMC_Command(32'd68059267);
    Send_IMC_Command(32'd54427780);
    Send_IMC_Command(32'd92504398);
    Send_IMC_Command(32'd84837509);
    Send_IMC_Command(32'd86934879);
    Send_IMC_Command(32'd75597190);
    Send_IMC_Command(32'd55476871);
    Send_IMC_Command(32'd92440187);
    Send_IMC_Command(32'd92637034);
    Send_IMC_Command(32'd236945408);
    Send_IMC_Command(32'd86982529);
    Send_IMC_Command(32'd85929858);
    Send_IMC_Command(32'd68124803);
    Send_IMC_Command(32'd54493316);
    Send_IMC_Command(32'd92504399);
    Send_IMC_Command(32'd84903045);
    Send_IMC_Command(32'd87000400);
    Send_IMC_Command(32'd75597190);
    Send_IMC_Command(32'd55542407);
    Send_IMC_Command(32'd92440188);
    Send_IMC_Command(32'd92637035);

endtask : REC_Col_SBOX