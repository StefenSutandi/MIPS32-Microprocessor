-- Praktikum EL3011 Arsitektur Sistem Komputer
-- Modul : 2
-- Percobaan : 4
-- Tanggal : 04 Desember 2024
-- Kelompok : 12
-- Rombongan : D
-- Nama (NIM) 1 : Stefen Sutandi (13222091)
-- Nama (NIM) 2 : Chessy Anggraini Putri (13222084)
-- Nama File : sign_extender.vhd
-- Deskripsi : Perancangan Sign Extender 16-bit ke 32-bit. 

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY sign_extender IS
	PORT (
		D_In 	: IN std_logic_vector (15 DOWNTO 0); -- Data Input 1 
		D_Out 	: OUT std_logic_vector (31 DOWNTO 0) -- Data Input 2
	);
END sign_extender;

architecture behavioral of sign_extender is
begin
	process(D_In)
	begin
		if (D_In(15) = '1') then
			D_Out <= "1111111111111111" & D_In;
		elsif (D_In(15) = '0') then
			D_Out <= "0000000000000000" & D_In;
		end if;
	end process;
end behavioral;
