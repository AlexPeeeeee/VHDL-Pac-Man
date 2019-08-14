----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:37:35 03/06/2015 
-- Design Name: 
-- Module Name:    Pacman_move - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity Pacman_move is

port ( 
			Y, X : in unsigned(10 downto 0));

end Pacman_move;
architecture Behavioral of Pacman_move is
begin

Pacman : entity Pacman
	PORT MAP ( 
						X   => X,
						Y   => Y);

end Behavioral;

