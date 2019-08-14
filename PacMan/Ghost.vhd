----------------------------------------------------------------------------------
-- Company: University of Essex
-- Engineer: Alex Pryke
-- Acknowledgements: initial code script was provided by Luca Citi
-- Description: Creates ghost sprites and moves them
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Ghost is
	Generic (R  : in natural := 24);
   port ( PIXEL_CK : in std_logic;
      X, Y: in unsigned (10 downto 0);
		RGB_PACMAN : in std_logic_vector (7 downto 0);
		ghost_sync : in std_logic;
      RGB : out std_logic_vector (7 downto 0); 
      GAME_OVER : out std_logic := '0');
		
end Ghost;

architecture Behavorial of Ghost is
	-- ghosts coordinates
  	signal G1x				 : unsigned (10 downto 0) := "00011110000";
	signal G1y				 : unsigned (10 downto 0) := "01000011111"; -- to  y= 543
	signal G2x				 : unsigned (10 downto 0) := "01001000100"; -- to x = 550
	signal G2y				 : unsigned (10 downto 0) := "00000110010"; -- to y = 50
	signal G3x				 : unsigned (10 downto 0) := "00010101010"; -- to x = 270
	signal G3y				 : unsigned (10 downto 0) := "00100101100";
	signal G4x				 : unsigned (10 downto 0) := "00100001110";
	signal G4y				 : unsigned (10 downto 0) := "00000110010";
	-- ghosts colour
	signal G1colour		 :  std_logic_vector (7 downto 0) := "11100000";
	signal G2colour		 :  std_logic_vector (7 downto 0) := "00011100";
	signal G3colour		 :  std_logic_vector (7 downto 0) := "00000011";
	signal G4colour		 :  std_logic_vector (7 downto 0) := "00011111";
	signal colour		    :  std_logic_vector (7 downto 0) ;
	signal direction 		: boolean := true;
	signal square 			: natural := 1;
begin
	process
	begin
	wait until rising_edge(PIXEL_CK);
	-- checks to see if pacman is touched by ghost
	IF colour /= "00000000" and RGB_PACMAN /= "00000000" THEN
		GAME_OVER <= '1';
	END IF;
	
	end process;

	process 
	begin 
	wait until rising_edge(ghost_sync);
	-- changes XY coordinates of ghosts
		IF G1y >= 563 then 
			direction <= true;
		elsif G1y <= 45 then 
			direction <= false;
		END IF;
		
		IF direction then
			G1y <= G1y - 5;
			G2y <= G2y + 5;
			G3x <= G3x + 5;
	   else 
			G1y <= G1y + 5;
			G2y <= G2y - 5;
			G3x <= G3x - 5;
	   END IF;
		IF square = 1 then 
			G4y <= G4y + 2;
			IF G4y = 544 then Square <= square + 1; END IF;
		elsif square = 2 then 
			G4x <= G4x + 2;
			IF G4x = 550 then Square <= square + 1; END IF;
		elsif square = 3 then 
			G4y <= G4y - 2;
			IF G4y = 50 then Square <= square + 1; END IF;
		elsif square = 4 then 
			G4x <= G4x - 2;
			IF G4x = 270 then Square <= 1; END IF;
		end if; 
		
	end process;

		-- outputs ghost colours	
	colour <= G1colour when (X >=	(G1x - 10)) and (X <= (G1x + 10)) and (Y >=(G1y - 10)) and (Y <= (G1y + 10)) else 
			    G2colour when (X >=	(G2x - 10)) and (X <= (G2x + 10)) and (Y >=(G2y - 10)) and (Y <= (G2y + 10)) else 
			    G3colour when (X >=	(G3x - 10)) and (X <= (G3x + 10)) and (Y >=(G3y - 10)) and (Y <= (G3y + 10)) else 
			    G4colour when (X >=	(G4x - 10)) and (X <= (G4x + 10)) and (Y >=(G4y - 10)) and (Y <= (G4y + 10)) else "00000000";
	
	RGB <= colour;

end Behavorial;
