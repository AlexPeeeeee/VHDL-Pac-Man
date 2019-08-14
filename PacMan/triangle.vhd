----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:35:52 02/13/2015 
-- Design Name: 
-- Module Name:    triangle - Behavioral 
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

entity triangle is
   port (
      --PIXEL_CK : in std_logic;
      X, Y: in unsigned (10 downto 0);
      RGB : out std_logic_vector (7 downto 0); 
      MASK : out std_logic ;
		PIXEL_CLK : in   std_logic);
end triangle;

architecture Behavioral of triangle is

begin

PROCESS

begin

WAIT UNTIL RISING_EDGE(PIXEL_CLK);
--if (X >= 100) and (X <= 200) and (Y >= 100) and (Y <= 200) THEN

IF (X > 250) and (Y < 300) and (X < Y + 150)then
	RGB <= "11111111";
ELSE
	RGB <= "00000000";
END IF;


END PROCESS;

end Behavioral;

