----------------------------------------------------------------------------------
-- Company: University of Essex
-- Engineer: Alex Pryke
-- Acknowledgements: initial code script was provided by Luca Citi
-- Description: creates yellow circle for pacman
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Pacman is
   port (
		CX : in unsigned (10 downto 0); -- XY of Pacman
		CY : in unsigned (10 downto 0);
      X, Y: in unsigned (10 downto 0); --HCOUNT AND VCOUNT
      RGB : out std_logic_vector (7 downto 0)); 
end Pacman;

architecture Behavorial of Pacman is
	signal R  : natural := 17;
   signal DX2, DY2 : unsigned ((2*X'high+1) downto 0) := (others => '0'); 
   constant R2 : unsigned(DX2'range) := to_unsigned(R * R, DX2'length);
   signal DX, DY : unsigned (X'range) := (others => '0'); 
   signal COLOUR : std_logic_vector (7 downto 0) := "11111100" ;

begin
   DX <= X - CX when X > CX else CX - X; -- creates disc of pacman
   DY <= Y - CY when Y > CY else CY - Y;
   DX2 <= DX * DX;
   DY2 <= DY * DY;
   RGB <= COLOUR when (DX2 + DY2 < R2) else "00000000";

end Behavorial;
