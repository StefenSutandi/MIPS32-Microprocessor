-- Praktikum EL3011 Arsitektur Sistem Komputer
-- Modul : 2
-- Percobaan : 1
-- Tanggal : 04 Desember 2024
-- Kelompok : 12
-- Rombongan : D
-- Nama (NIM) 1 : Stefen Sutandi (13222091)
-- Nama (NIM) 2 : Chessy Anggraini Putri (13222084)
-- Nama File : mux_2to1_32bit.vhd
-- Deskripsi : Membuat komponen multiplexer 2-to-1 dengan lebar data 32-bit dan memilih antara dua input data berdasarkan sinyal selector.

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY mux_2to1_32bit IS
PORT (
	D1 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 1
	D2 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 2
	Y : OUT std_logic_vector (31 DOWNTO 0); -- Selected Data
	S : IN std_logic -- Selector
);
END mux_2to1_32bit;

ARCHITECTURE behavior OF mux_2to1_32bit IS
	BEGIN
		PROCESS (D1, D2, S)
			BEGIN
				IF (S='0') THEN
					Y <= D1;
				ELSIF (S='1') THEN
					Y <= D2; 
			END IF;
	END PROCESS;
END behavior;