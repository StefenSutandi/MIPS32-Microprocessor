-- Praktikum EL3011 Arsitektur Sistem Komputer
-- Modul : 2
-- Percobaan : 2
-- Tanggal : 04 Desember 2024
-- Kelompok : 12
-- Rombongan : D
-- Nama (NIM) 1 : Stefen Sutandi (13222091)
-- Nama (NIM) 2 : Chessy Anggraini Putri (13222084)
-- Nama File : lshift_26_28.vhd
-- Deskripsi : Left shifter 26-bit ke 28-bit

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY lshift_26_28 IS
	PORT (
		D_IN 	: IN STD_LOGIC_VECTOR (25 DOWNTO 0); -- Input 26-bit;
		D_OUT 	: OUT STD_LOGIC_VECTOR (27 DOWNTO 0) -- Output 28-bit;
	);
END lshift_26_28;

architecture behavioral of lshift_26_28 is 
begin
	D_OUT <= D_IN & "00";
end behavioral;