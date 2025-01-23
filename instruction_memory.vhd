-- Praktikum EL3011 Arsitektur Sistem Komputer
-- Modul : 1
-- Percobaan : 1
-- Tanggal : 18 November 2024
-- Kelompok : 12
-- Rombongan : D
-- Nama (NIM) 1 : Stefen Sutandi (13222091)
-- Nama (NIM) 2 : Chessy Anggraini Putri (13222084)
-- Nama File : instruction_memory.vhd
-- Deskripsi : Implementasi instruction memory

LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY altera_mf;
USE altera_mf.all;

ENTITY instruction_memory IS
	PORT (
		ADDR : IN STD_LOGIC_VECTOR (7 DOWNTO 0);   -- Address Input
		clock : IN STD_LOGIC := '1';               -- Clock
		INSTR : OUT STD_LOGIC_VECTOR (31 DOWNTO 0) -- Instruction Output
	);
END ENTITY;

ARCHITECTURE structural OF instruction_memory IS
	SIGNAL memory_output : STD_LOGIC_VECTOR (31 DOWNTO 0); -- Internal Memory Output Signal

	COMPONENT altsyncram 
		GENERIC (
			init_file      : STRING;  -- Name of the .mif file
			operation_mode : STRING;  -- Operation Mode
			widthad_a      : NATURAL; -- Width of Address Input
			width_a        : NATURAL  -- Width of Data Output
		);
		PORT (
			clock0    : IN STD_LOGIC;                     -- Clock Input
			address_a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Address Input
			q_a       : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- Data Output
		);
	END COMPONENT;

BEGIN
	-- Map Output Signal
	INSTR <= memory_output;

	-- Instantiate the Memory Component
	altsyncram_component : altsyncram
		GENERIC MAP (
			init_file      => "imemory.mif",  -- Memory Initialization File
			operation_mode => "ROM",         -- ROM Mode
			widthad_a      => 8,             -- 8-bit Address Width
			width_a        => 32             -- 32-bit Data Width
		)
		PORT MAP (
			clock0    => clock,
			address_a => ADDR,
			q_a       => memory_output
		);
END structural;
