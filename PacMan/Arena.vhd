----------------------------------------------------------------------------------
-- Company: University of Essex
-- Engineer: Alex Pryke
-- Acknowledgements: initial code script was provided by Luca Citi
-- Description: creates walled environemnt for pacman
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Arena is
   port (
      X, Y: in unsigned (10 downto 0);
      RGB : out std_logic_vector (7 downto 0));
end Arena;

architecture Behavorial of Arena is 
	signal colour		 :  std_logic_vector (7 downto 0) := "00000011";	
begin
		-- creates arena from select statements	
	RGB <= colour when (X >=	25)  and (X <= 135) and (Y >= 100) and (Y <= 120) else
			 colour when (X >=	25)  and (X <= 135) and (Y >= 300) and (Y <= 320) else
			 colour when (X >=	25)  and (X <= 135) and (Y >= 480) and (Y <= 500) else 
			 colour when (X >=	0)   and (X <= 25)  and (Y >= 0)   and (Y <= 600) else
			 colour when (X >=	200) and (X <= 220) and (Y >= 480) and (Y <= 600) else
			 colour when (X >=	200) and (X <= 220) and (Y >= 0)   and (Y <= 120) else
			 colour when (X >=	775) and (X <= 800) and (Y >= 0)   and (Y <= 600) else 
			 colour when (X >=	690) and (X <= 800) and (Y >= 100) and (Y <= 120) else
			 colour when (X >=	690) and (X <= 800) and (Y >= 300) and (Y <= 320) else
			 colour when (X >=	690) and (X <= 800) and (Y >= 480) and (Y <= 500) else
			 colour when (X >=	600) and (X <= 620) and (Y >= 480) and (Y <= 600) else
			 colour when (X >=	600) and (X <= 620) and (Y >= 0)   and (Y <= 120) else
			 colour when (X >=	340) and (X <= 350) and (Y >= 350) and (Y <= 500) else
			 colour when (X >=	340) and (X <= 350) and (Y >= 100) and (Y <= 250) else
			 colour when (X >=	450) and (X <= 460) and (Y >= 350) and (Y <= 500) else
			 colour when (X >=	450) and (X <= 460) and (Y >= 100) and (Y <= 250) else
			 colour when (X >=	340) and (X <= 460) and (Y >= 350) and (Y <= 360) else
			 colour when (X >=	340) and (X <= 460) and (Y >= 490) and (Y <= 500) else
			 colour when (X >=	340) and (X <= 460) and (Y >= 100) and (Y <= 110) else
			 colour when (X >=	340) and (X <= 460) and (Y >= 240) and (Y <= 250) else
			 colour when (X >=	0)   and (X <= 800) and (Y >= 0)   and (Y <= 10)  else
			 colour when (X >=	0)   and (X <= 800) and (Y >= 590) and (Y <= 600) else
			 "00000000";

end Behavorial;
