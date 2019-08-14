-------------------------------------------------------------------
-- Engineer:  Alexander Pryke 1104382
-- Create Date:    15:32:50 01/30/2015 
-- Design Name: 	 VHDL Assignment1
-- Module Name:    Four_Digits - Behavioral 
-- Target Devices: Digilent Basys 2 FPGA
-- Tool versions: Xilinx 14.6
-- Description: 4 digit settable countdown timer
-- Revision 0.01 
-- Additional Comments: 
--
-------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity Four_Digits is
	port (	D1, D0 			: in  UNSIGNED (3 DOWNTO 0);
				MULTIPLEX_CK	: in  STD_LOGIC;
				CATHODES 		: out STD_LOGIC_VECTOR (6 downto 0);
				ANODES   		: out STD_LOGIC_VECTOR (3 downto 0)); 
				
				attribute LOC : string;
				attribute LOC of CATHODES : signal is "M12 L13 P12 N11 N14 H12 L14";
				attribute LOC of ANODES   : signal is "K14 M13 J12 F12";
end Four_Digits;


architecture Behavioral of Four_Digits is
--SIGNAL active_digit: UNSIGNED;
SIGNAL DIGIT: UNSIGNED (3 DOWNTO 0);
begin

PROCESS

begin
--WAIT UNTIL RISING_EDGE(MULTIPLEX_CK);
--active_digit <= active_digit + 1;

END PROCESS;

WITH MULTIPLEX_CK SELECT
ANODES <= "1110" WHEN '0', -- anodes are active low
			 "0111" WHEN OTHERS;
			 
	
WITH MULTIPLEX_CK select
DIGIT <= D0 WHEN '0', -- outputs the corresponding 
			D1 WHEN OTHERS;
			
four_digits : entity one_digit (Behavioral)	-- entity for one-digit			
port map ( CATHODES => CATHODES,					-- (7 seg decoder)
                DIGIT => DIGIT);			
					 
end Behavioral;

