task Simon_Demo(output logic passed);
    //This demonstates the Simon 64/128 Feistel Cipher using test pattern provided in paper. 
    //As such it only passes with the hardcoded plain text, predicted and key values
    logic [63:0] plain_text, cipher_text, predicted;
    
    static logic [31:0] round_keys [0:43] = '{
        'h03020100,
        'h0b0a0908,
        'h13121110,
        'h1b1a1918,
        'h70a011c3,
        'hb770ec49,
        'h57e3e835,
        'hd397bc42,
        'h94dcf81f,
        'hbf4b5f18,
        'h8e5dabb9,
        'hdbf4a863,
        'hcd0c28fc,
        'h5cb69911,
        'h79f112a5,
        'h77205863,
        'h99880c12,
        'h1ce97c58,
        'hc8ed2145,
        'hb800dbb8,
        'he86a2756,
        'h7c06d4dd,
        'hab52df0a,
        'h247f66a8,
        'h53587ca6,
        'hd25c13f1,
        'h4583b64b,
        'h7d9c960d,
        'hefbfc2f3,
        'h89ed8513,
        'h308dfc4e,
        'hbf1a2a36,
        'he1499d70,
        'h4ce4d2ff,
        'h32b7ebef,
        'hc47505c1,
        'hd0e929e8,
        'h8fe484b9,
        'h42054bee,
        'haf77bae2,
        'h18199c02,
        'h719e3f1c,
        'h0c1cf793,
        'h15df4696
    };
    
    plain_text = 64'h656b696c20646e75;
    Load_Simon_State_1Col(plain_text,'h0);  
    Print_Simon_State_Bytes_1Col('h0, "Plain Text");
    
    for (int i = 0; i < 44; i = i+2) begin
        Load_Simon_Key_1Col(round_keys[i],'h40);
        Simon_Even();
        
        Load_Simon_Key_1Col(round_keys[i+1],'h40);
        Simon_Odd();
    end 
    
    Print_Simon_State_Bytes_1Col('h0, "Cipher Text");
    Get_Simon_State_Bytes_1Col('h0, cipher_text);
    
    //Author's test vector Cipher Text
    predicted = 64'h44c8fc20b9dfa07a;
    passed = (cipher_text == predicted);
endtask

//Common / Utility
task Load_Simon_Key_1Col(input logic [31:0] byte_in, input int start_addr);

    Load_IMC_Byte(byte_in[7:0],start_addr+'h0);
    Load_IMC_Byte(byte_in[15:8],start_addr+'h8);
    
    Load_IMC_Byte(byte_in[23:16],start_addr+'h10);
    Load_IMC_Byte(byte_in[31:24],start_addr+'h18);
    
endtask


task Load_Simon_State_1Col(input logic [63:0] byte_in, input int start_addr);

    Load_IMC_Byte(byte_in[7:0],start_addr+'h0);
    Load_IMC_Byte(byte_in[15:8],start_addr+'h8);
    
    Load_IMC_Byte(byte_in[23:16],start_addr+'h10);
    Load_IMC_Byte(byte_in[31:24],start_addr+'h18);
    
    Load_IMC_Byte(byte_in[39:32],start_addr+'h20);
    Load_IMC_Byte(byte_in[47:40],start_addr+'h28);
    
    Load_IMC_Byte(byte_in[55:48],start_addr+'h30);
    Load_IMC_Byte(byte_in[63:56],start_addr+'h38);
    
endtask

//Round Functions

task Simon_Even();
    Send_IMC_Command(32'd71252064);
    Send_IMC_Command(32'd69220705);
    Send_IMC_Command(32'd69286498);
    Send_IMC_Command(32'd69352291);
    Send_IMC_Command(32'd69418084);
    Send_IMC_Command(32'd69483877);
    Send_IMC_Command(32'd69549670);
    Send_IMC_Command(32'd69615463);
    Send_IMC_Command(32'd69673064);
    Send_IMC_Command(32'd69738857);
    Send_IMC_Command(32'd69804650);
    Send_IMC_Command(32'd69870443);
    Send_IMC_Command(32'd69936236);
    Send_IMC_Command(32'd70002029);
    Send_IMC_Command(32'd70067822);
    Send_IMC_Command(32'd70133615);
    Send_IMC_Command(32'd70199408);
    Send_IMC_Command(32'd70265201);
    Send_IMC_Command(32'd70330994);
    Send_IMC_Command(32'd70396787);
    Send_IMC_Command(32'd70462580);
    Send_IMC_Command(32'd70528373);
    Send_IMC_Command(32'd70594166);
    Send_IMC_Command(32'd70659959);
    Send_IMC_Command(32'd70725752);
    Send_IMC_Command(32'd70791545);
    Send_IMC_Command(32'd70857338);
    Send_IMC_Command(32'd70923131);
    Send_IMC_Command(32'd70988924);
    Send_IMC_Command(32'd71054717);
    Send_IMC_Command(32'd71120510);
    Send_IMC_Command(32'd71186303);
    Send_IMC_Command(32'd90177536);
    Send_IMC_Command(32'd90243329);
    Send_IMC_Command(32'd90309122);
    Send_IMC_Command(32'd90374915);
    Send_IMC_Command(32'd90440708);
    Send_IMC_Command(32'd90506501);
    Send_IMC_Command(32'd90572294);
    Send_IMC_Command(32'd90638087);
    Send_IMC_Command(32'd90703880);
    Send_IMC_Command(32'd90769673);
    Send_IMC_Command(32'd90835466);
    Send_IMC_Command(32'd90901259);
    Send_IMC_Command(32'd90967052);
    Send_IMC_Command(32'd91032845);
    Send_IMC_Command(32'd91098638);
    Send_IMC_Command(32'd91164431);
    Send_IMC_Command(32'd91230224);
    Send_IMC_Command(32'd91296017);
    Send_IMC_Command(32'd91361810);
    Send_IMC_Command(32'd91427603);
    Send_IMC_Command(32'd91493396);
    Send_IMC_Command(32'd91559189);
    Send_IMC_Command(32'd91624982);
    Send_IMC_Command(32'd91690775);
    Send_IMC_Command(32'd91756568);
    Send_IMC_Command(32'd91822361);
    Send_IMC_Command(32'd91888154);
    Send_IMC_Command(32'd91953947);
    Send_IMC_Command(32'd92019740);
    Send_IMC_Command(32'd92085533);
    Send_IMC_Command(32'd92151326);
    Send_IMC_Command(32'd92217119);
    Send_IMC_Command(32'd87949312);
    Send_IMC_Command(32'd88015105);
    Send_IMC_Command(32'd85983746);
    Send_IMC_Command(32'd86049539);
    Send_IMC_Command(32'd86115332);
    Send_IMC_Command(32'd86181125);
    Send_IMC_Command(32'd86246918);
    Send_IMC_Command(32'd86312711);
    Send_IMC_Command(32'd86378504);
    Send_IMC_Command(32'd86444297);
    Send_IMC_Command(32'd86510090);
    Send_IMC_Command(32'd86575883);
    Send_IMC_Command(32'd86641676);
    Send_IMC_Command(32'd86707469);
    Send_IMC_Command(32'd86773262);
    Send_IMC_Command(32'd86839055);
    Send_IMC_Command(32'd86904848);
    Send_IMC_Command(32'd86970641);
    Send_IMC_Command(32'd87036434);
    Send_IMC_Command(32'd87102227);
    Send_IMC_Command(32'd87168020);
    Send_IMC_Command(32'd87233813);
    Send_IMC_Command(32'd87299606);
    Send_IMC_Command(32'd87365399);
    Send_IMC_Command(32'd87431192);
    Send_IMC_Command(32'd87496985);
    Send_IMC_Command(32'd87562778);
    Send_IMC_Command(32'd87628571);
    Send_IMC_Command(32'd87694364);
    Send_IMC_Command(32'd87760157);
    Send_IMC_Command(32'd87825950);
    Send_IMC_Command(32'd87891743);
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

endtask : Simon_Even

task Simon_Odd();
    Send_IMC_Command(32'd69146720);
    Send_IMC_Command(32'd67115361);
    Send_IMC_Command(32'd67181154);
    Send_IMC_Command(32'd67246947);
    Send_IMC_Command(32'd67312740);
    Send_IMC_Command(32'd67378533);
    Send_IMC_Command(32'd67444326);
    Send_IMC_Command(32'd67510119);
    Send_IMC_Command(32'd67567720);
    Send_IMC_Command(32'd67633513);
    Send_IMC_Command(32'd67699306);
    Send_IMC_Command(32'd67765099);
    Send_IMC_Command(32'd67830892);
    Send_IMC_Command(32'd67896685);
    Send_IMC_Command(32'd67962478);
    Send_IMC_Command(32'd68028271);
    Send_IMC_Command(32'd68094064);
    Send_IMC_Command(32'd68159857);
    Send_IMC_Command(32'd68225650);
    Send_IMC_Command(32'd68291443);
    Send_IMC_Command(32'd68357236);
    Send_IMC_Command(32'd68423029);
    Send_IMC_Command(32'd68488822);
    Send_IMC_Command(32'd68554615);
    Send_IMC_Command(32'd68620408);
    Send_IMC_Command(32'd68686201);
    Send_IMC_Command(32'd68751994);
    Send_IMC_Command(32'd68817787);
    Send_IMC_Command(32'd68883580);
    Send_IMC_Command(32'd68949373);
    Send_IMC_Command(32'd69015166);
    Send_IMC_Command(32'd69080959);
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
    Send_IMC_Command(32'd85860384);
    Send_IMC_Command(32'd85926177);
    Send_IMC_Command(32'd83894818);
    Send_IMC_Command(32'd83960611);
    Send_IMC_Command(32'd84026404);
    Send_IMC_Command(32'd84092197);
    Send_IMC_Command(32'd84157990);
    Send_IMC_Command(32'd84223783);
    Send_IMC_Command(32'd84289576);
    Send_IMC_Command(32'd84355369);
    Send_IMC_Command(32'd84421162);
    Send_IMC_Command(32'd84486955);
    Send_IMC_Command(32'd84552748);
    Send_IMC_Command(32'd84618541);
    Send_IMC_Command(32'd84684334);
    Send_IMC_Command(32'd84750127);
    Send_IMC_Command(32'd84815920);
    Send_IMC_Command(32'd84881713);
    Send_IMC_Command(32'd84947506);
    Send_IMC_Command(32'd85013299);
    Send_IMC_Command(32'd85079092);
    Send_IMC_Command(32'd85144885);
    Send_IMC_Command(32'd85210678);
    Send_IMC_Command(32'd85276471);
    Send_IMC_Command(32'd85342264);
    Send_IMC_Command(32'd85408057);
    Send_IMC_Command(32'd85473850);
    Send_IMC_Command(32'd85539643);
    Send_IMC_Command(32'd85605436);
    Send_IMC_Command(32'd85671229);
    Send_IMC_Command(32'd85737022);
    Send_IMC_Command(32'd85802815);
    Send_IMC_Command(32'd88088608);
    Send_IMC_Command(32'd88154401);
    Send_IMC_Command(32'd88220194);
    Send_IMC_Command(32'd88285987);
    Send_IMC_Command(32'd88351780);
    Send_IMC_Command(32'd88417573);
    Send_IMC_Command(32'd88483366);
    Send_IMC_Command(32'd88549159);
    Send_IMC_Command(32'd88614952);
    Send_IMC_Command(32'd88680745);
    Send_IMC_Command(32'd88746538);
    Send_IMC_Command(32'd88812331);
    Send_IMC_Command(32'd88878124);
    Send_IMC_Command(32'd88943917);
    Send_IMC_Command(32'd89009710);
    Send_IMC_Command(32'd89075503);
    Send_IMC_Command(32'd89141296);
    Send_IMC_Command(32'd89207089);
    Send_IMC_Command(32'd89272882);
    Send_IMC_Command(32'd89338675);
    Send_IMC_Command(32'd89404468);
    Send_IMC_Command(32'd89470261);
    Send_IMC_Command(32'd89536054);
    Send_IMC_Command(32'd89601847);
    Send_IMC_Command(32'd89667640);
    Send_IMC_Command(32'd89733433);
    Send_IMC_Command(32'd89799226);
    Send_IMC_Command(32'd89865019);
    Send_IMC_Command(32'd89930812);
    Send_IMC_Command(32'd89996605);
    Send_IMC_Command(32'd90062398);
    Send_IMC_Command(32'd90128191);

endtask : Simon_Odd