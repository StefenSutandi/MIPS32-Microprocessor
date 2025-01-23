-- Praktikum EL3011 Arsitektur Sistem Komputer
-- Modul : 3
-- Percobaan : 1
-- Tanggal : 19 Desember 2024
-- Kelompok : 12
-- Rombongan : D
-- Nama (NIM) 1 : Stefen Sutandi (13222091)
-- Nama (NIM) 2 : Chessy Anggraini Putri (13222084)
-- Nama (NIM) 3 : Michael Reynaldi Tamara (13222055)
-- Nama File : ALU.vhd
-- Deskripsi : Mengimplementasikan ALU MIPS32Â®

LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.NUMERIC_STD.ALL; 
 
ENTITY ALU IS 
 PORT  ( 
  OPRND_1  : IN std_logic_vector (31 DOWNTO 0); -- Data Input 1  
  OPRND_2 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 2 
  OP_SEL : IN std_logic;  -- Operation Select 
  RESULT : OUT  std_logic_vector (31 DOWNTO 0)  -- Data Output 
 ); 
END ALU; 

ARCHITECTURE behavior OF ALU IS

 COMPONENT cla_32 
  PORT ( 
   OPRND_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);   -- Operand 1 
   OPRND_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);  -- Operand 2
   C_IN : IN  STD_LOGIC;            -- Carry In
   RESULT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);  -- Result
   C_OUT : OUT STD_LOGIC             -- Overflow
 ); 
 END COMPONENT; 

 SIGNAL twoscomplement : std_logic_vector (31 downto 0);
 SIGNAL cla_in2 : std_logic_vector (31 downto 0);
 
BEGIN
 add_ins : cla_32
  PORT MAP (OPRND_1,cla_in2,'0',RESULT);
  
    process (OPRND_1, OPRND_2, OP_SEL)
 BEGIN
  twoscomplement <= std_logic_vector(unsigned(NOT OPRND_2) + 1);
  IF (OP_SEL = '0') THEN
   cla_in2 <= OPRND_2;
  ELSIF (OP_SEL = '1') THEN 
   cla_in2 <= twoscomplement;
  END IF;
 END PROCESS; 
END behavior;