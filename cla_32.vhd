-- Praktikum EL3011 Arsitektur Sistem Komputer
-- Modul : 2
-- Percobaan : 3
-- Tanggal : 04 Desember 2024
-- Kelompok : 12
-- Rombongan : D
-- Nama (NIM) 1 : Stefen Sutandi (13222091)
-- Nama (NIM) 2 : Chessy Anggraini Putri (13222084)
-- Nama File : cla_32.vhd
-- Deskripsi : Perancangan Carry-Lookahead Adder 32-bit.

LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.NUMERIC_STD.ALL; 
 
ENTITY cla_32 IS 
 PORT ( 
  OPRND_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);   -- Operand 1 
  OPRND_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);  -- Operand 2
  C_IN : IN  STD_LOGIC;            -- Carry In
  RESULT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);  -- Result
  C_OUT : OUT STD_LOGIC             -- Overflow
 ); 
END cla_32; 

ARCHITECTURE behavior OF cla_32 IS

    -- Signals for Generate and Propagate
    SIGNAL Gen : STD_LOGIC_VECTOR (31 DOWNTO 0);  -- Generate
    SIGNAL Pro : STD_LOGIC_VECTOR (31 DOWNTO 0);  -- Propagate
    SIGNAL Car : STD_LOGIC_VECTOR (31 DOWNTO 0);  -- Carry

BEGIN
    GEN_PROP: FOR i IN 0 TO 31 GENERATE -- Generate
        Gen(i) <= OPRND_1(i) AND OPRND_2(i);
        Pro(i) <= OPRND_1(i) OR OPRND_2(i);
    END GENERATE;

    Car(0) <= C_IN; 

    CARRY_CALC: FOR i IN 1 TO 31 GENERATE
        Car(i) <= Gen(i-1) OR (Pro(i-1) AND Car(i-1));
    END GENERATE;

    SUM_PROC: FOR i IN 0 TO 31 GENERATE
        RESULT(i) <= OPRND_1(i) XOR OPRND_2(i) XOR Car(i);
    END GENERATE;

    C_OUT <= Car(31);
END behavior;
