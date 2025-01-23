-- Praktikum EL3011 Arsitektur Sistem Komputer
-- Modul : 2
-- Percobaan : 6
-- Tanggal : 04 Desember 2024
-- Kelompok : 12
-- Rombongan : D
-- Nama (NIM) 1 : Stefen Sutandi (13222091)
-- Nama (NIM) 2 : Chessy Anggraini Putri (13222084)
-- Nama File : cu.vhd
-- Deskripsi : Perancangan Control Unit (CU) untuk Single-Cycle MIPS32®.

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY cu IS
	PORT (
		OP_In : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		FUNCT_In : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		Sig_Jmp : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		Sig_Bne : OUT STD_LOGIC;
		Sig_Branch : OUT STD_LOGIC;
		Sig_MemtoReg : OUT STD_LOGIC;
		Sig_MemRead : OUT STD_LOGIC;
		Sig_MemWrite : OUT STD_LOGIC;
		Sig_RegDest : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		Sig_RegWrite : OUT STD_LOGIC;
		Sig_ALUSrc : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		Sig_ALUCtrl : OUT STD_LOGIC
	);
END cu;

architecture behavioral of cu is
begin
	PROCESS(OP_IN, FUNCT_In)
	BEGIN
		IF (OP_IN="000000") THEN
			Sig_Jmp <= "00";
			Sig_Bne <= '0';
			Sig_Branch <= '0';
			Sig_MemtoReg <= '0';
			Sig_MemRead <='0';
			Sig_MemWrite <='0';
			Sig_ALUSrc <="00";
			
			IF (FUNCT_In="000000") THEN
				Sig_RegDest <= "00";
				Sig_RegWrite <='0';
			ELSE
				Sig_RegDest <= "01";
				Sig_RegWrite <= '1';
			END IF;
			
			IF (FUNCT_In="100010") THEN 
				Sig_ALUCtrl<='1';  
			ELSE 
				Sig_ALUCtrl<= '0'; 
			END IF;
			
		ELSE
			Sig_ALUCtrl<= '0';
			
			IF (OP_In="000010") THEN 
				Sig_Jmp <= "01";  
			ELSE 
				Sig_Jmp <="00"; 
			END IF;
			
			IF (OP_In="000100") THEN 
				Sig_Branch <='1';  
			ELSE 
				Sig_Branch <='0';
			END IF;
			
			IF (OP_In="000101") THEN 
				Sig_Bne <='1';  
			ELSE 
				Sig_Bne <='0'; 
			END IF;
			
			IF (OP_In="001000" OR OP_In="100011") THEN 
				Sig_RegWrite <='1';  
			ELSE
				Sig_RegWrite <='0'; 
			END IF;
			
			IF (OP_In="001000" OR OP_In="100011" OR OP_In="101011") THEN
				Sig_ALUSrc <="01";  
			ELSE 
				Sig_ALUSrc <="00"; 
			END IF;
			
			IF (OP_In="100011") THEN 
				Sig_MemtoReg <='1';
				Sig_MemRead <='1';
			ELSE
				Sig_MemtoReg <='0'; Sig_MemRead <='0'; 
			END IF;
			
			IF (OP_In="101011") THEN 
				Sig_MemWrite <='1';  
			ELSE 
				Sig_MemWrite <='0'; 
			END IF;
			
		END IF;        
END PROCESS;
	
end behavioral;
