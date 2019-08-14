------------------------------------------------------------------
-- Engineer: 	Alexander Pryke 1104382
-- Create Date:    11:24:01 01/21/2015 
-- Design Name: 	 VHDL Assignment1
-- Module Name:    one_digit - Behavioral 
-- Target Devices: Digilent Basys 2 FPGA
-- Tool versions: Xilinx 14.6
-- Description: 4 digit settable countdown timer
-- Revision 0.01 
-- Additional Comments: 
------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity one_digit is
    Port ( DIGIT : in  UNSIGNED(3 downto 0);
           CATHODES : out  STD_LOGIC_VECTOR (6 downto 0));
end one_digit;

architecture Behavioral of one_digit is

begin

WITH DIGIT SELECT
CATHODES <= "1111001" WHEN "0001", --1
				"0100100" WHEN "0010", --2
				"0110000" WHEN "0011", --3
				"0011001" WHEN "0100", --4
				"0010010" WHEN "0101", --5
				"0000010" WHEN "0110", --6
				"1111000" WHEN "0111", --7
				"0000000" WHEN "1000", --8 
				"0011000" WHEN "1001", --9
				"1000000" WHEN "0000", -- 0
				"0111111" WHEN OTHERS; -- DASH FOR INVALID NUMBERS			
end Behavioral;

