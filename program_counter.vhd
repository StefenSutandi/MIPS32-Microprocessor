-- Praktikum EL3011 Arsitektur Sistem Komputer
-- Modul : 2
-- Percobaan : 1
-- Tanggal : 04 Desember 2024
-- Kelompok : 12
-- Rombongan : D
-- Nama (NIM) 1 : Stefen Sutandi (13222091)
-- Nama (NIM) 2 : Chessy Anggraini Putri (13222084)
-- Nama File : program_counter.vhd
-- Deskripsi : Merancang program counter 32-bit menggunakan register berbasis D Flip-flop.

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.ALL;

ENTITY program_counter IS
 PORT  (
    clk : IN  STD_LOGIC;
    PC_in : IN  STD_LOGIC_VECTOR (31 DOWNTO 0);
    PC_out : OUT  STD_LOGIC_VECTOR (31 DOWNTO 0)
  );
END program_counter; 

architecture behavioral of program_counter is
begin
	process(clk)
	begin
		if rising_edge(clk) then
			PC_out <= PC_in;
		end if;
	end process;
end behavioral;