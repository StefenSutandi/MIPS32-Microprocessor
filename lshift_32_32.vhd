-- Praktikum EL3011 Arsitektur Sistem Komputer
-- Modul : 2
-- Percobaan : 2
-- Tanggal : 04 Desember 2024
-- Kelompok : 12
-- Rombongan : D
-- Nama (NIM) 1 : Stefen Sutandi (13222091)
-- Nama (NIM) 2 : Chessy Anggraini Putri (13222084)
-- Nama File : lshift_32_32.vhd
-- Deskripsi : Left shifter 32-bit ke 32-bit

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY lshift_32_32 IS
 PORT (
   D_IN 	: IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Input 32-bit;
   D_OUT	: OUT STD_LOGIC_VECTOR (31 DOWNTO 0) -- Output 32-bit;
  );
END lshift_32_32; 

architecture behavioral of lshift_32_32 is
begin
	D_OUT <= D_IN(29 DOWNTO 0) & "00";
end behavioral;