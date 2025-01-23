-- Praktikum EL3011 Arsitektur Sistem Komputer
-- Modul : 2
-- Percobaan : 5
-- Tanggal : 04 Desember 2024
-- Kelompok : 12
-- Rombongan : D
-- Nama (NIM) 1 : Stefen Sutandi (13222091)
-- Nama (NIM) 2 : Chessy Anggraini Putri (13222084)
-- Nama File : bus_merger.vhd
-- Deskripsi : Membuat komponen bus merging yang menggabungkan dua input 4-bit dan 28-bit menjadi satu output 32-bit.

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY bus_merger IS 
	PORT ( 
		 DATA_IN1 	: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		 DATA_IN2 	: IN STD_LOGIC_VECTOR (27 DOWNTO 0);
		 DATA_OUT	: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		); 
END bus_merger;

ARCHITECTURE BEHAVIOR OF bus_merger IS
BEGIN
	DATA_OUT <= DATA_IN2 & DATA_IN1;
END BEHAVIOR;
