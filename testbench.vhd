-- Praktikum EL3011 Arsitektur Sistem Komputer
-- Modul : 3
-- Percobaan : 2
-- Tanggal : 19 Desember 2024
-- Kelompok : 12
-- Rombongan : D
-- Nama (NIM) 1 : Stefen Sutandi (13222091)
-- Nama (NIM) 2 : Chessy Anggraini Putri (13222084)
-- Nama (NIM) 3 : Michael Reynaldi Tamara (13222055)
-- Nama File : testbench.vhd
-- Deskripsi : Testbench untuk Top-Level Design MIPS32®

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY testbench IS
END testbench;

ARCHITECTURE behavioral OF testbench IS
    FUNCTION std_logic_vector_to_string(vector : std_logic_vector) RETURN STRING IS
        VARIABLE result : STRING(1 TO vector'LENGTH);
    BEGIN
        FOR i IN vector'RANGE LOOP
            IF vector(i) = '1' THEN
                result(i - vector'LOW + 1) := '1';
            ELSE
                result(i - vector'LOW + 1) := '0';
            END IF;
        END LOOP;
        RETURN result;
    END FUNCTION;
	
    COMPONENT top_level IS
        PORT (
            clock_in        : IN STD_LOGIC;
            reset           : IN STD_LOGIC;
            ALUOUT          : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            PCIN_out        : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            PCOUT_out       : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            INSTR_out       : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            ADDR1_out       : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            ADDR2_out       : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            ADDR3_out       : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            adder1_out      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            adder2_out      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            OPIN_out        : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
            FUNCTIN_out     : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
            SigJmp          : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            SigBne          : OUT STD_LOGIC;
            SigBranch       : OUT STD_LOGIC;
            SigMemtoReg     : OUT STD_LOGIC;
            SigMemRead      : OUT STD_LOGIC;
            SigMemWrite     : OUT STD_LOGIC;
            SigRegDest      : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
            SigRegWrite     : OUT STD_LOGIC;
            SigALUSrc       : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
            SigALUCtrl      : OUT STD_LOGIC;
            RDDATA1_out     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            RDDATA2_out     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            WR_EN           : OUT STD_LOGIC;
            ADDR_2          : OUT STD_LOGIC_VECTOR (4 DOWNTO 0); 
            ADDR_1          : OUT STD_LOGIC_VECTOR (4 DOWNTO 0); 
            ADDR_3          : OUT STD_LOGIC_VECTOR (4 DOWNTO 0); 
            WR_Data_3       : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
            INSTR           : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
            ADDR            : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)  
        );
    END COMPONENT;

    -- Signal Declaration
    SIGNAL s_clock_in       : STD_LOGIC := '0';
    SIGNAL s_reset          : STD_LOGIC := '1';
    SIGNAL s_ALUOUT         : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_PCIN_out       : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_PCOUT_out      : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_INSTR_out      : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_ADDR1_out      : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_ADDR2_out      : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_ADDR3_out      : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_adder1_out     : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_adder2_out     : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_OPIN_out       : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL s_FUNCTIN_out    : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL s_SigJmp         : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL s_SigBne         : STD_LOGIC;
    SIGNAL s_SigBranch      : STD_LOGIC;
    SIGNAL s_SigMemtoReg    : STD_LOGIC;
    SIGNAL s_SigMemRead     : STD_LOGIC;
    SIGNAL s_SigMemWrite    : STD_LOGIC;
    SIGNAL s_SigRegDest     : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL s_SigRegWrite    : STD_LOGIC;
    SIGNAL s_SigALUSrc      : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL s_SigALUCtrl     : STD_LOGIC;
    SIGNAL s_RDDATA1_out    : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_RDDATA2_out    : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_WR_EN          : STD_LOGIC;
    SIGNAL s_ADDR           : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL s_WR_Data_3      : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL s_ADDR_1         : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_ADDR_2         : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_ADDR_3         : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL s_INSTR          : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL s_OPRND_1 		: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_OPRND_2 		: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_OP_SEL  		: STD_LOGIC := '0';


BEGIN
    -- Instantiate the Top-Level Design
	DUT: top_level
		PORT MAP (
			clock_in    => s_clock_in,
			reset       => s_reset,
			ALUOUT      => s_ALUOUT,
			PCIN_out    => s_PCIN_out,
			PCOUT_out   => s_PCOUT_out,
			INSTR_out   => s_INSTR_out,
			ADDR1_out   => s_ADDR1_out,
			ADDR2_out   => s_ADDR2_out,
			ADDR3_out   => s_ADDR3_out,
			adder1_out  => s_adder1_out,
			adder2_out  => s_adder2_out,
			OPIN_out    => s_OPIN_out,
			FUNCTIN_out => s_FUNCTIN_out,
			SigJmp      => s_SigJmp,
			SigBne      => s_SigBne,
			SigBranch   => s_SigBranch,
			SigMemtoReg => s_SigMemtoReg,
			SigMemRead  => s_SigMemRead,
			SigMemWrite => s_SigMemWrite,
			SigRegDest  => s_SigRegDest,
			SigRegWrite => s_SigRegWrite,
			SigALUSrc   => s_SigALUSrc,
			SigALUCtrl  => s_SigALUCtrl,
			RDDATA1_out => s_RDDATA1_out,
			RDDATA2_out => s_RDDATA2_out,
			WR_EN       => s_WR_EN,
			ADDR        => s_ADDR,
			WR_Data_3   => s_WR_Data_3,
			ADDR_1      => s_ADDR_1,
			ADDR_2      => s_ADDR_2,
			ADDR_3      => s_ADDR_3,
			INSTR       => s_INSTR
		);

    -- Clock Generation
    clock_process : PROCESS
    BEGIN
        LOOP
            s_clock_in <= '0';
            WAIT FOR 10 ns;
            s_clock_in <= '1';
            WAIT FOR 10 ns;
        END LOOP;
    END PROCESS;

    -- Reset Process
	reset_process : PROCESS
	BEGIN
		s_reset <= '1';
		WAIT FOR 50 ns;
		s_reset <= '0';
		WAIT;
	END PROCESS;
	
	-- Stimulus Process
	stimulus_process : PROCESS
	BEGIN
		-- Contoh pemberian nilai operand dan opcode
		WAIT FOR 60 ns; -- Tunggu setelah reset selesai
		s_OPRND_1 <= X"0000000F"; -- Operand 1
		s_OPRND_2 <= X"00000001"; -- Operand 2
		s_OP_SEL <= '0'; -- Operasi penjumlahan
		WAIT FOR 100 ns;

		s_OP_SEL <= '1'; -- Operasi pengurangan (atau not)
		WAIT FOR 100 ns;

		WAIT;
	END PROCESS;

	-- Debugging ALUOUT
    debug_process : PROCESS
    BEGIN
        WAIT FOR 10 ns; -- Tunggu waktu simulasi awal
        LOOP
            REPORT "ALUOUT: " & std_logic_vector_to_string(s_ALUOUT);
            WAIT FOR 100 ns; -- Laporkan nilai ALUOUT setiap 100 ns
        END LOOP;
    END PROCESS;

END ARCHITECTURE behavioral;