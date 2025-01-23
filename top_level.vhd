-- Praktikum EL3011 Arsitektur Sistem Komputer
-- Modul : 3
-- Percobaan : 1
-- Tanggal : 19 Desember 2024
-- Kelompok : 12
-- Rombongan : D
-- Nama (NIM) 1 : Stefen Sutandi (13222091)
-- Nama (NIM) 2 : Chessy Anggraini Putri (13222084)
-- Nama (NIM) 3 : Michael Reynaldi Tamara (13222055)
-- Nama File : top_level.vhd
-- Deskripsi : Mengimplementasikan Top-Level Design MIPS32Â®

library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY altera_mf;
USE altera_mf.all;
USE altera_mf.altera_mf_components.ALL;

ENTITY top_level is
	port(
		clock_in		: IN STD_LOGIC;
		reset			: IN STD_LOGIC;
		ALUOUT			: OUT STD_LOGIC_VECTOR(31 downto 0);
		PCIN_out 		: OUT STD_LOGIC_VECTOR(31 downto 0);
		PCOUT_out 		: OUT STD_LOGIC_VECTOR(31 downto 0);
		INSTR_out		: OUT STD_LOGIC_VECTOR(31 downto 0);
		ADDR1_out		: OUT STD_LOGIC_VECTOR(4 downto 0);
		ADDR2_out		: OUT STD_LOGIC_VECTOR(4 downto 0);
		ADDR3_out		: OUT STD_LOGIC_VECTOR(4 downto 0);
		adder1_out		: OUT STD_LOGIC_VECTOR(31 downto 0);
		adder2_out		: OUT STD_LOGIC_VECTOR(31 downto 0);
		OPIN_out		: OUT STD_LOGIC_VECTOR(5 downto 0);
		FUNCTIN_out		: OUT STD_LOGIC_VECTOR(5 downto 0);
		SigJmp			: OUT STD_LOGIC_VECTOR(1 downto 0);
		SigBne			: OUT STD_LOGIC;
		SigBranch 		: OUT STD_LOGIC;
		SigMemtoReg 	: OUT STD_LOGIC;
		SigMemRead 		: OUT STD_LOGIC;
		SigMemWrite 	: OUT STD_LOGIC;
		SigRegDest 		: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		SigRegWrite 	: OUT STD_LOGIC;
		SigALUSrc 		: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		SigALUCtrl 		: OUT STD_LOGIC;
		RDDATA1_out		: OUT STD_LOGIC_VECTOR(31 downto 0);
		RDDATA2_out		: OUT STD_LOGIC_VECTOR(31 downto 0);
		WR_EN  			: OUT STD_LOGIC;    
		ADDR_2  		: OUT STD_LOGIC_VECTOR (4 DOWNTO 0); 
		ADDR_1  		: OUT STD_LOGIC_VECTOR (4 DOWNTO 0); 
		ADDR_3  		: OUT STD_LOGIC_VECTOR (4 DOWNTO 0); 
		WR_Data_3  		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		INSTR 			: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		ADDR  			: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)  
	);
END top_level;

architecture behavioral of top_level is

component ALU
	PORT(
		OPRND_1 : IN std_logic_vector (31 DOWNTO 0);
		OPRND_2	: IN std_logic_vector (31 DOWNTO 0);
		OP_SEL 	: IN std_logic;  
		RESULT 	: OUT  std_logic_vector (31 DOWNTO 0)  
	);
END component;

component bus_merger
	PORT (
		DATA_IN1 :  IN  STD_LOGIC_VECTOR (3 DOWNTO 0); 
		DATA_IN2 :  IN  STD_LOGIC_VECTOR (27 DOWNTO 0);
		DATA_OUT :  OUT  STD_LOGIC_VECTOR (31 DOWNTO 0) 
	);
END component;

component cla_32
	PORT (
    OPRND_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);  
    OPRND_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);  
    C_IN 	: IN  STD_LOGIC;     
    RESULT 	: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);  
    C_OUT 	: OUT STD_LOGIC       
   );
END component;

component comparator
	PORT (
		D_1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0); 
		D_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0); 
		EQ 	: OUT  STD_LOGIC  
	);
END component;

component cu
	PORT  (
		OP_In 		: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		FUNCT_In 	: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		Sig_Jmp 	: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		Sig_Bne 	: OUT STD_LOGIC;
		Sig_Branch 	: OUT STD_LOGIC;
		Sig_MemtoReg: OUT STD_LOGIC;
		Sig_MemRead : OUT STD_LOGIC;
		Sig_MemWrite: OUT STD_LOGIC;
		Sig_RegDest : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		Sig_RegWrite: OUT STD_LOGIC;
		Sig_ALUSrc 	: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		Sig_ALUCtrl : OUT STD_LOGIC
	);
END component;

component data_memory
	PORT  (
		ADDR  	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);  
		WR_EN 	: IN STD_LOGIC;        
		RD_EN 	: IN STD_LOGIC;        
		clock  	: IN STD_LOGIC := '1'; 
		RD_Data : OUT STD_LOGIC_VECTOR (7 DOWNTO 0); 
		WR_Data : IN STD_LOGIC_VECTOR (7 DOWNTO 0)  
	);
END component;

component instruction_memory
	PORT  (
		ADDR  	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);  
		clock  	: IN STD_LOGIC := '1';    
		INSTR  	: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)  
	);
END component;

component lshift_26_28
	PORT (
		D_IN 	: IN STD_LOGIC_VECTOR (25 DOWNTO 0); 
		D_OUT 	: OUT STD_LOGIC_VECTOR (27 DOWNTO 0) 
	);
END component;

component lshift_32_32
	PORT (
		D_IN 	: IN STD_LOGIC_VECTOR (31 DOWNTO 0); 
		D_OUT 	: OUT STD_LOGIC_VECTOR (31 DOWNTO 0) 
	);
END component;

component mux_2to1_32bit
	PORT  (
		D1 : IN  std_logic_vector (31 DOWNTO 0);  
		D2 : IN  std_logic_vector (31 DOWNTO 0);  
		Y  : OUT  std_logic_vector (31 DOWNTO 0); 
		S  : IN  std_logic                       
	);
END component;

component mux_4to1_5bit
	PORT  (
		D1 : IN  std_logic_vector (4 DOWNTO 0);  
		D2 : IN  std_logic_vector (4 DOWNTO 0);  
		D3 : IN  std_logic_vector (4 DOWNTO 0);  
		D4 : IN  std_logic_vector (4 DOWNTO 0);  
		Y  : OUT  std_logic_vector (4 DOWNTO 0); 
		S  : IN  std_logic_vector (1 DOWNTO 0) 
	);
END component;

component mux_4to1_32bit
	PORT  (
		D1 : IN  std_logic_vector (31 DOWNTO 0);  
		D2 : IN  std_logic_vector (31 DOWNTO 0);  
		D3 : IN  std_logic_vector (31 DOWNTO 0);  
		D4 : IN  std_logic_vector (31 DOWNTO 0);  
		Y  : OUT  std_logic_vector (31 DOWNTO 0); 
		S  : IN  std_logic_vector (1 DOWNTO 0)   
		);
END component;

component program_counter
	PORT  (
		clk 	: IN  STD_LOGIC;
		PC_in 	: IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
		PC_out 	: OUT  STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END component;

component reg_file
	PORT  (
		clock  		: IN STD_LOGIC;    
		WR_EN  		: IN STD_LOGIC;    
		ADDR_1  	: IN STD_LOGIC_VECTOR (4 DOWNTO 0); 
		ADDR_2  	: IN STD_LOGIC_VECTOR (4 DOWNTO 0); 
		ADDR_3  	: IN STD_LOGIC_VECTOR (4 DOWNTO 0); 
		WR_Data_3  	: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		RD_Data_1  	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		RD_Data_2  	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
		
	);
END component;

component sign_extender
	PORT  (
		D_In 	: IN std_logic_vector (15 DOWNTO 0);  
		D_Out 	: OUT std_logic_vector (31 DOWNTO 0)  
  );
END component;

signal out_mux21_1, out_mux21_2, out_mux21_3, out_mux41_1, out_mux41_2, out_signex, out_ls32, add1_out, add2_out, adr, ALUrslt, ALUin, RData, rd1, rd2, wr_d, instruct, bmout, zero32bit	: STD_LOGIC_VECTOR(31 downto 0);
signal s_bne, s_brnch, s_bnb, s_memreg, s_memrd, s_memw, s_regw, s_aluctrl, comp_rslt, c1, c2 : std_logic;
signal adr3, zero5bit 			: std_logic_vector (4 downto 0);
signal s_regd, s_alusrc, s_jump : std_logic_vector(1 downto 0);
signal out_ls28 				: std_logic_vector(27 downto 0);
signal in_ls28 					: std_logic_vector(25 downto 0);
signal in_signex 				: std_logic_vector (15 downto 0);

begin
	ALU_1 : ALU
		port map(
			OPRND_1	=> rd1,
			OPRND_2 => out_mux41_2,
			OP_SEL 	=> s_aluctrl,
			RESULT 	=> ALUrslt
	);
	
	busmerg : bus_merger
		port map (
			DATA_IN1 => add1_out(31 downto 28),
			DATA_IN2 => out_ls28(27 downto 0),
			DATA_OUT => bmout
		);
	
	fir_add : cla_32
		port map (
			OPRND_1 => adr,
			OPRND_2 => X"00000004",
			C_IN 	=> '0',
			RESULT  => add1_out,
			C_OUT 	=> c1
		);
	
	sec_add : cla_32
		port map (
			OPRND_1 => out_ls32,
			OPRND_2 => add1_out,
			C_IN 	=> '0',
			RESULT  => add2_out,
			C_OUT 	=> c2
		);
	
	pembanding : comparator
		port map(
			D_1	=> rd1,
			D_2	=> rd2,
			EQ 	=> comp_rslt
		);
		
	controlunit : cu
		port map(
			OP_In 			=> instruct(31 downto 26),
			FUNCT_In 		=> instruct(5 downto 0),
			Sig_Jmp 		=> s_jump,
			Sig_Bne 		=> s_bne,
			Sig_Branch 		=> s_brnch,
			Sig_MemtoReg	=> s_memreg,
			Sig_MemRead 	=> s_memrd,
			Sig_MemWrite	=> s_memw,
			Sig_RegDest 	=> s_regd,
			Sig_RegWrite	=> s_regw,
			Sig_ALUSrc 		=> s_alusrc,
			Sig_ALUCtrl 	=> s_aluctrl
		);
	
	datamemory : data_memory
		port map(
			ADDR  	=> ALUrslt(7 downto 0),
			WR_EN 	=> s_memw,
			RD_EN 	=> s_memrd,
			clock  	=> clock_in,
			RD_Data => RData(7 downto 0),
			WR_Data => rd2(7 downto 0)
		);
		
	instructionmemory : instruction_memory
		port map(
			ADDR  	=> adr(7 downto 0),
			clock  	=> clock_in,
			INSTR  	=> instruct
		);
		
	leftshift2628 : lshift_26_28
		port map(
			D_IN	=> instruct(25 downto 0),
			D_OUT 	=> out_ls28
		);
		
	leftshift3232 : lshift_32_32
		port map(
			D_IN 	=> out_signex,
			D_OUT 	=> out_ls32
		);
	
	mux21_1 : mux_2to1_32bit
		port map(
			D1 => add1_out,
			D2 => add2_out,
			Y => out_mux21_1,
			S => s_bnb
		);
		
	mux21_2 : mux_2to1_32bit
		port map(
			D1 => out_mux41_1,
			D2 => X"00000000",
			Y => out_mux21_2,
			S => reset
		);
	
	mux21_3 : mux_2to1_32bit
		port map(
			D1 => ALUrslt,
			D2 => RData,
			Y => out_mux21_3,
			S => s_memreg
		);
		
	mux41_1 : mux_4to1_32bit
		port map(
			D1 => out_mux21_1,
			D2 => bmout,
			D3 => zero32bit,
			D4 => zero32bit,
			Y  => out_mux41_1,
			S  => s_jump
		);
	
	mux41_2 : mux_4to1_32bit
		port map(
			D1 => rd2,
			D2 => out_signex,
			D3 => zero32bit,
			D4 => zero32bit,
			Y  => out_mux41_2,
			S  => s_alusrc
		);
		
	mux41_3 : mux_4to1_5bit
		port map(
			D1 => instruct(20 downto 16),
			D2 => instruct(15 downto 11),
			D3 => zero5bit,
			D4 => zero5bit,
			Y  => adr3,
			S  => s_regd
		);	
	
	progcounter : program_counter
		port map(
			clk 	=> clock_in,
			PC_in 	=> out_mux21_2,
			PC_out 	=> adr
		);
		
	regfile : reg_file
		port map(
			clock  		=> clock_in,
			WR_EN  		=> s_regw,
			ADDR_1  	=> instruct(25 downto 21), 
			ADDR_2  	=> instruct(20 downto 16), 
			ADDR_3  	=> adr3,
			WR_Data_3  	=> out_mux21_3, 
			RD_Data_1  	=> rd1, 
			RD_Data_2  	=> rd2
		);
		
	s_ext : sign_extender
		port map(
			D_In 	=> instruct(15 downto 0),
			D_Out 	=> out_signex
		);
	
	zero32bit		<= (others => '0');
	zero5bit 		<= (others => '0');
	s_bnb			<= (s_brnch and (not comp_rslt)) or (s_bne and (not comp_rslt));
	ALUOUT			<= ALUrslt;
	PCIN_out 		<= out_mux21_2;
	PCOUT_out 		<= adr;
	INSTR_out		<= instruct;
	ADDR1_out		<= instruct(25 downto 21);
	ADDR2_out		<= instruct(20 downto 16);
	ADDR3_out		<= adr3;
	adder1_out		<= add1_out;
	adder2_out		<= add2_out;
	OPIN_out		<= instruct(31 downto 26);
	FUNCTIN_out		<= instruct(5 downto 0);
	SigJmp			<= s_jump;
	SigBne			<= s_bne;
	SigBranch 		<= s_brnch;
	SigMemtoReg 	<= s_memreg;
	SigMemRead 		<= s_memrd;
	SigMemWrite 	<= s_memw;
	SigRegDest 		<= s_regd;
	SigRegWrite 	<= s_regw;
	SigALUSrc 		<= s_alusrc;
	SigALUCtrl 		<= s_aluctrl;
	RDDATA1_out		<= rd1;
	RDDATA2_out		<= rd2;
	WR_EN  			<= s_regw;
	ADDR_1  		<= instruct(25 downto 21);
	ADDR_2  		<= instruct(20 downto 16); 
	ADDR_3  		<= adr3;
	WR_Data_3  		<= out_mux21_3; 
	INSTR  			<= instruct;
	ADDR  			<= adr(7 downto 0);
	
end behavioral;