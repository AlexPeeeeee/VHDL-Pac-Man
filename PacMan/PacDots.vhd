----------------------------------------------------------------------------------
-- Company: University of Essex
-- Engineer: Alex Pryke
-- Acknowledgements: initial code script was provided by Luca Citi
-- Description: Creates pacdots
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity PacDots is
Generic (R  : in natural := 8);
   port (
      PIXEL_CK : in std_logic;
      X, Y: in unsigned (10 downto 0);
		RGB_PACMAN 	 : in std_logic_vector (7 downto 0);
      RGB : out std_logic_vector (7 downto 0));
end PacDots;

architecture Behavorial of PacDots is
   signal DX2, DY2 : unsigned ((2*X'high+1) downto 0) := (others => '0'); 
   --signal FLAG : std_logic;
   constant R2 : unsigned(DX2'range) := to_unsigned(R * R, DX2'length);
   signal COLOUR : std_logic_vector (7 downto 0) := "11111111" ;
   --signal DX, DY : unsigned (X'range) := (others => '0'); 
	signal D0x				 :  unsigned (10 downto 0); 
	signal D0y				 :  unsigned (10 downto 0); 
	-- pacdot coordinates
  	signal D1x				 : unsigned (10 downto 0) := "00001000101";
	signal D1y				 : unsigned (10 downto 0) := "00011111010";
	signal D2x				 : unsigned (10 downto 0) := "00001000111";
	signal D2y				 : unsigned (10 downto 0) := "00101011110";
	signal D3x				 : unsigned (10 downto 0) := "01011011101";
	signal D3y				 : unsigned (10 downto 0) := "00101011110";
	signal D4x				 : unsigned (10 downto 0) := "01011011011";
	signal D4y				 : unsigned (10 downto 0) := "00011111011";
	signal D5x				 : unsigned (10 downto 0) := "01011011001";
	signal D5y				 : unsigned (10 downto 0) := "01000111010";
	signal D6x				 : UNSIGNED (10 downto 0) := "00001001010";
	signal D6y				 : UNSIGNED (10 downto 0) := "01000111010";
	signal D7x				 : UNSIGNED (10 downto 0) := "01011011010";
	signal D7y				 : UNSIGNED (10 downto 0) := "00001000110";
	signal D8x				 : UNSIGNED (10 downto 0) := "00110010011";
	signal D8y				 : UNSIGNED (10 downto 0) := "01000111010";
	signal D9x				 : UNSIGNED (10 downto 0) := "00110010000";
	signal D9y				 : UNSIGNED (10 downto 0) := "01000111010";
	signal D10x				 : UNSIGNED (10 downto 0) := "00110010101";
	signal D10y				 : UNSIGNED (10 downto 0) := "00001000110";

begin	 -- selects the correct pacdot coordinates when HCOUNT AND VCOUNT are close to the desired dot position
D0x <= D1x       when  (X >= (D1x - 10))  and (X <= (D1x + 10)) and (Y >= (D1y - 10))  and (Y <= (D1y + 10)) else
		 D2x       when  (X >= (D2x - 10))  and (X <= (D2x + 10)) and (Y >= (D2y - 10))  and (Y <= (D2y + 10)) else
		 D3x       when  (X >= (D3x - 10))  and (X <= (D3x + 10)) and (Y >= (D3y - 10))  and (Y <= (D3y + 10)) else
		 D4x       when  (X >= (D4x - 10))  and (X <= (D4x + 10)) and (Y >= (D4y - 10))  and (Y <= (D4y + 10)) else
		 D5x       when  (X >= (D5x - 10))  and (X <= (D5x + 10)) and (Y >= (D5y - 10))  and (Y <= (D5y + 10)) else
		 D6x       when  (X >= (D6x - 10))  and (X <= (D6x + 10)) and (Y >= (D6y - 10))  and (Y <= (D6y + 10)) else
		 D7x       when  (X >= (D7x - 10))  and (X <= (D7x + 10)) and (Y >= (D7y - 10))  and (Y <= (D7y + 10)) else
		 D8x       when  (X >= (D8x - 10))  and (X <= (D8x + 10)) and (Y >= (D8y - 10))  and (Y <= (D8y + 10)) else
		 D9x       when  (X >= (D9x - 10))  and (X <= (D9x + 10)) and (Y >= (D9y - 10))  and (Y <= (D9y + 10)) else
	    D10x      when  (X >= (D10x - 10)) and (X <= (D10x + 10))and (Y >=(D10y - 10))  and (Y <=(D10y + 10)) else  "00000000000";

D0y <= D1y       when (Y >= (D1y - 10))  and (Y <= (D1y + 10)) else
		 D2y       when (Y >= (D2y - 10))  and (Y <= (D2y + 10)) else
		 D3y       when (Y >= (D3y - 10))  and (Y <= (D3y + 10)) else
		 D4y       when (Y >= (D4y - 10))  and (Y <= (D4y + 10)) else
		 D5y       when (Y >= (D5y - 10))  and (Y <= (D5y + 10)) else 
	    D6y       when (Y >= (D6y - 10))  and (Y <= (D6y + 10)) else
		 D7y       when (Y >= (D7y - 10))  and (Y <= (D7y + 10)) else
		 D8y       when (Y >= (D8y - 10))  and (Y <= (D8y + 10)) else
		 D9y       when (Y >= (D9y - 10))  and (Y <= (D9y + 10)) else
		 D10y      when (Y >= (D10y - 10)) and (Y <= (D10y + 10)) else  "00000000000";	 
   process
   begin
	
      wait until rising_edge(PIXEL_CK);
      if X <= D0x - R or X >= D0x + R then
         DX2 <= R2; -- creates circle for dots
      else
         DX2 <= DX2 + (X * 2) - (D0x * 2) - 1;
      end if;
      
      if X = 0 then
         if (Y <= D0y - R) or (Y >= D0y + R) then
				DY2 <= R2;
         else
            DY2 <= DY2 + (Y * 2) - (D0y * 2) - 1;
         end if;
      end if;
		IF COLOUR /= "00000000" and RGB_PACMAN /= "00000000" THEN
		-- used to determine which pacdot has been eaten and removes
		-- it form display
			IF     (D0x = D1x) then D1x <= "11111111111"; 
			ELSIF  (D0x = D2x) then D2x <= "11111111111";
			ELSIF  (D0x = D3x) then D3x <= "11111111111";
			ELSIF  (D0x = D4x) then D4x <= "11111111111";
			ELSIF  (D0x = D5x) then D5x <= "11111111111";
			ELSIF  (D0x = D6x) then D6x <= "11111111111";
			ELSIF  (D0x = D7x) then D7x <= "11111111111";
			ELSIF  (D0x = D8x) then D8x <= "11111111111";
			ELSIF  (D0x = D9x) then D9x <= "11111111111";
			ELSIF  (D0x = D10x)then D10x <= "11111111111"; 
			END IF;
		END IF;
		
   end process;
	
   RGB <= COLOUR when (DX2 + DY2 < R2) else "00000000";

end Behavorial;
