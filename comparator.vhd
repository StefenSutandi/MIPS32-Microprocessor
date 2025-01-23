-- Praktikum EL3011 Arsitektur Sistem Komputer
-- Modul : 2
-- Percobaan : 4
-- Tanggal : 04 Desember 2024
-- Kelompok : 12
-- Rombongan : D
-- Nama (NIM) 1 : Stefen Sutandi (13222091)
-- Nama (NIM) 2 : Chessy Anggraini Putri (13222084)
-- Nama File : comparator.vhd
-- Deskripsi : Membuat komponen comparator 32-bit yang menghasilkan output high (1) jika kedua input sama dan low (0) jika kedua input berbeda.

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY comparator IS 
	PORT ( 
			D_1 	: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			D_2 	: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			EQ		: OUT STD_LOGIC -- Hasil perbandingan EQ
		  ); 
END comparator;

ARCHITECTURE BEHAVIOR OF comparator IS
BEGIN
	PROCESS(D_1, D_2) IS
	BEGIN
		IF(D_1 = D_2) THEN
			EQ <= '1';
		ELSE
			EQ <= '0';
		END IF;
	END PROCESS;
END BEHAVIOR;
