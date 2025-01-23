-- Praktikum EL3011 Arsitektur Sistem Komputer
-- Modul : 1
-- Percobaan : 2
-- Tanggal : 18 November 2024
-- Kelompok : 12
-- Rombongan : D
-- Nama (NIM) 1 : Stefen Sutandi (13222091)
-- Nama (NIM) 2 : Chessy Anggraini Putri (13222084)
-- Nama File : reg_file.vhd
-- Deskripsi : Implementasi register file dengan proses baca tulis terpisah

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY reg_file IS
	PORT (
		clock      : IN STD_LOGIC;                     -- clock
		WR_EN      : IN STD_LOGIC;                     -- write enable
		ADDR_1     : IN STD_LOGIC_VECTOR(4 DOWNTO 0);  -- Input address 1
		ADDR_2     : IN STD_LOGIC_VECTOR(4 DOWNTO 0);  -- Input address 2
		ADDR_3     : IN STD_LOGIC_VECTOR(4 DOWNTO 0);  -- Write address
		WR_Data_3  : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Data to write
		RD_Data_1  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);-- Output data 1
		RD_Data_2  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- Output data 2
	);
END ENTITY;

ARCHITECTURE BEHAVIOR OF reg_file IS
	-- Define a memory array for 32 registers, each 32-bit wide
	TYPE ramtype IS ARRAY (31 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL mem : ramtype := (OTHERS => (OTHERS => '0')); -- Initialize to 0

BEGIN
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			-- Read operations (asynchronous behavior for reading)
			RD_Data_1 <= mem(to_integer(unsigned(ADDR_1)));
			RD_Data_2 <= mem(to_integer(unsigned(ADDR_2)));

			-- Write operation (synchronous behavior for writing)
			IF WR_EN = '1' AND ADDR_3 /= "00000" THEN
				mem(to_integer(unsigned(ADDR_3))) <= WR_Data_3;
			END IF;

			-- Ensure register 0 is always 0 (hardwired logic)
			mem(0) <= (OTHERS => '0');
		END IF;
	END PROCESS;
END BEHAVIOR;
