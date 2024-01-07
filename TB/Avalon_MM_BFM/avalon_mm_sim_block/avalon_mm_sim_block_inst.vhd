	component avalon_mm_sim_block is
		port (
			clk               : in  std_logic                     := 'X';             -- clk
			reset             : in  std_logic                     := 'X';             -- reset
			avm_address       : out std_logic_vector(31 downto 0);                    -- address
			avm_readdata      : in  std_logic_vector(31 downto 0) := (others => 'X'); -- readdata
			avm_writedata     : out std_logic_vector(31 downto 0);                    -- writedata
			avm_waitrequest   : in  std_logic                     := 'X';             -- waitrequest
			avm_write         : out std_logic;                                        -- write
			avm_read          : out std_logic;                                        -- read
			avm_readdatavalid : in  std_logic                     := 'X'              -- readdatavalid
		);
	end component avalon_mm_sim_block;

	u0 : component avalon_mm_sim_block
		port map (
			clk               => CONNECTED_TO_clk,               --       clk.clk
			reset             => CONNECTED_TO_reset,             -- clk_reset.reset
			avm_address       => CONNECTED_TO_avm_address,       --        m0.address
			avm_readdata      => CONNECTED_TO_avm_readdata,      --          .readdata
			avm_writedata     => CONNECTED_TO_avm_writedata,     --          .writedata
			avm_waitrequest   => CONNECTED_TO_avm_waitrequest,   --          .waitrequest
			avm_write         => CONNECTED_TO_avm_write,         --          .write
			avm_read          => CONNECTED_TO_avm_read,          --          .read
			avm_readdatavalid => CONNECTED_TO_avm_readdatavalid  --          .readdatavalid
		);

