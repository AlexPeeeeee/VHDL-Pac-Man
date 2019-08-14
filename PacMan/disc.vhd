----------------------------------------------------------------------------------
-- Company: University of Essex
-- Engineer: Anthony Barison
-- Acknowledgements: initial code script was provided by Luca Citi
-- Create Date:    12:53:12 01/15/2013 
-- Description: an added condition allows to generate a circle.
-- 2013-03-07 LCiti: Switched to the recommended NUMERIC_STD library
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity disc is
   generic (
      CX : natural := 320;
      CY : natural := 240;
      R  : natural := 100;
      COLOUR : std_logic_vector (7 downto 0) := "01110001" );
   port (
      PIXEL_CK : in std_logic;
      X, Y: in unsigned (10 downto 0);
		
      RGB : out std_logic_vector (7 downto 0); 
      MASK : out std_logic );
end disc;

architecture Iter of disc is
   signal DX2, DY2 : unsigned ((2*X'high+1) downto 0) := (others => '0'); 
   signal FLAG : std_logic;
   constant R2 : unsigned(DX2'range) := to_unsigned(R * R, DX2'length);
begin
   process
   begin
      wait until rising_edge(PIXEL_CK);
      if X <= CX - R or X >= CX + R then
         DX2 <= R2;
      else
         DX2 <= DX2 + (X * 2) - (CX * 2) - 1;
      end if;
      
      if X = 0 then
         if (Y <= CY - R) or (Y >= CY + R) then
            DY2 <= R2;
         else
            DY2 <= DY2 + (Y * 2) - (CY * 2) - 1;
         end if;
      end if;
   end process;
   
   -- DISC
   FLAG <= '1' when (DX2 + DY2 < R2) else '0';
   RGB <= COLOUR when FLAG = '1' else (OTHERS => '0');
   MASK <= FLAG;
end Iter;


architecture Mult of disc is
   signal DX, DY : unsigned (X'range) := (others => '0'); 
   signal DX2, DY2 : unsigned ((2*X'high+1) downto 0) := (others => '0'); 
   signal FLAG : std_logic;
   constant R2 : unsigned(DX2'range) := to_unsigned(R * R, DX2'length);
begin

   DX <= X - CX when X > CX else CX - X;
   DY <= Y - CY when Y > CY else CY - Y;
   DX2 <= DX * DX;
   DY2 <= DY * DY;
   
   -- DISC
   FLAG <= '1' when (DX2 + DY2 < R2) else '0';
   RGB <= COLOUR when FLAG = '1' else (OTHERS => '0');
   MASK <= FLAG;

end Mult;
