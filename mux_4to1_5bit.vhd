-- Praktikum EL3011 Arsitektur Sistem Komputer
-- Modul : 2
-- Percobaan : 3
-- Tanggal : 04 Desember 2024
-- Kelompok : 12
-- Rombongan : D
-- Nama (NIM) 1 : Stefen Sutandi (13222091)
-- Nama (NIM) 2 : Chessy Anggraini Putri (13222084)
-- Nama File : mux_4to1_5bit.vhd
-- Deskripsi : Membuat komponen multiplexer 4-to-1 dengan lebar data 5-bit.

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY mux_4to1_5bit IS
	PORT (
		D1 : IN std_logic_vector (4 DOWNTO 0); -- Data Input 1 
		D2 : IN std_logic_vector (4 DOWNTO 0); -- Data Input 2 
		D3 : IN std_logic_vector (4 DOWNTO 0); -- Data Input 3 
		D4 : IN std_logic_vector (4 DOWNTO 0); -- Data Input 4 
		Y : OUT std_logic_vector (4 DOWNTO 0); -- Selected Data
		S : IN std_logic_vector (1 DOWNTO 0) -- Selector
	);
END mux_4to1_5bit;

ARCHITECTURE BEHAVIORAL OF mux_4to1_5bit IS
	BEGIN
		PROCESS (D1,D2,D3,D4,S)
			BEGIN
			IF S = "00" THEN
				Y <= D1;
			ELSIF S = "01" THEN
				Y <= D2;
			ELSIF S = "10" THEN
				Y <= D3;
			ELSE
				Y <= D4;
			END IF;
		END PROCESS;
END BEHAVIORAL;