----------------------------------------------------------------------------------
-- Company: University of Essex
-- Engineer: Alex Pryke
-- Module Name:    main - Behavioral 
-- Project Name:   PACMAN GAME
-- Target Devices: XC3S100E-CP132 (DIGILENT - BASYS 2)
-- Description: This is the top level entity
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main is
   Port (UCLK       : in   std_logic;
			UP, DOWN	  : in 	std_logic;
			LEFT, RIGHT: in 	std_logic;
         RGB_OUT    : out  std_logic_vector(7 downto 0);
         HSYNC      : out  std_logic;
         VSYNC      : out  std_logic);
	 	
end main;


architecture Behavioral of main is

   signal HCOUNT, VCOUNT : unsigned(10 downto 0); -- H and V count signals
   signal BLANK          : std_logic; -- blanking signal
   signal RGB_PACMAN		 : std_logic_vector (7 downto 0); 
	-- is pacman colour when pacman should be outputted	
   signal RGB_GHOST  	 : std_logic_vector (7 downto 0); 
	-- is ghost colour when ghost should be outputted
	signal RGB_DOT 		 : std_logic_vector (7 downto 0); 
	-- is pacdot colour when pacdot should be outputted
	signal RGB_ARENA 		 : std_logic_vector (7 downto 0); 
	-- is blue colour when walls should be outputted
	signal Colour_out		 : std_logic_vector (7 downto 0); 
	-- colour that should be outputted to VGA
	signal GAME_OVER      : std_logic; -- defines when ghost catches pacman
	signal PacX 			 : unsigned(10 downto 0); -- Pacman XY coordinates
	signal PacY				 : unsigned(10 downto 0); 
	signal PX 		    	 : unsigned(10 downto 0) := "00001000110";
	signal PY				 : unsigned(10 downto 0) := "00001001011";
	signal sig_div			 : natural := 0; 
	-- signal divider to slow pacmans speed down
	signal last_move		 : natural := 0;
	-- records last move to stop collision
   signal V_sync		: std_logic;
	
begin
-- instantiation of 800x600 (@60Hz) vga driver
   vga_controller_800_60 : entity vga_controller_800_60(Behavioral)
   PORT MAP(rst => '0',
            pixel_clk => UCLK, --40MHz
            hs => HSYNC,       
            vs => V_sync,       
            hcount => HCOUNT,
            vcount => VCOUNT,
            blank  => BLANK );
	-- instantiation of all entities			
   Pacman : entity Pacman
		PORT MAP ( 	X   => HCOUNT,
						Y   => VCOUNT,
						CX => PacX,
						CY => PacY,
						RGB => RGB_PACMAN);
						
	PacDots : entity PacDots
		PORT MAP ( 	X   => HCOUNT,
						Y   => VCOUNT,
						PIXEL_CK => UCLK, RGB_PACMAN => RGB_PACMAN,
						RGB => RGB_DOT); 
	 
	 VSYNC <= V_sync;				
	 Ghost : entity Ghost
		PORT MAP ( 	X   => HCOUNT,
						Y   => VCOUNT,
						PIXEL_CK => UCLK,
						RGB => RGB_GHOST,
						ghost_sync => V_sync,
						RGB_PACMAN => RGB_PACMAN, 
						GAME_OVER => GAME_OVER);
						
	Arena : entity Arena
		PORT MAP (X => HCOUNT, 
					 Y => VCOUNT,
					RGB => RGB_ARENA); 
						

		
	process 
	begin -- proritises the RGB output colours
	WAIT UNTIL RISING_EDGE(UCLK);
	IF GAME_OVER =	'1' THEN
		Colour_out <= "11100000";
	ELSIF RGB_ARENA /= "00000000" THEN
		Colour_out <= RGB_ARENA;
	ELSIF RGB_PACMAN /= "00000000" THEN
		Colour_out <= RGB_PACMAN;
	ELSIF RGB_DOT /= "00000000" THEN
		Colour_out <= RGB_DOT;
	ELSIF RGB_GHOST /=	"00000000" THEN
		Colour_out <= RGB_GHOST;
	ELSE Colour_out <= "00000000";
	
	END IF;
	
		IF (RGB_ARENA /= "00000000") and (RGB_PACMAN /= "00000000") and HCOUNT < PX + 17 
					and HCOUNT > PX - 17 and VCOUNT < (PY + 17) and VCOUNT > (PY - 17) THEN
			
			IF last_move = 1 then
				PY <= PY + 1; -- stops pacman moving through walls
			ELSIF last_move = 2 then
				PY <= PY - 1;
			ELSIF last_move = 3 then
				PX <= PX + 1;		
			ELSIF last_move = 4 then
				PX <= PX - 1;	
			END IF;			
		else		
			IF sig_div = 200000 then -- signal divider to slow pacman down
				sig_div <= 0;-- pacmans movements
				IF UP = '1' AND LEFT /= '1' AND RIGHT /= '1' AND DOWN /= '1' THEN
					PY <= PY - 1;
					last_move <= 1;
				ELSIF DOWN = '1' AND LEFT /= '1' AND RIGHT /= '1' AND UP /= '1' THEN
					PY <= PY + 1;
					last_move <= 2;
				ELSIF LEFT = '1' AND UP /= '1' AND DOWN /= '1' AND RIGHT /= '1' THEN
					PX <= PX - 1;
					last_move <= 3;
				ELSIF RIGHT = '1' AND UP /= '1' AND DOWN /= '1' AND LEFT /= '1' THEN
					PX <= PX + 1;
					last_move <= 4;
				END IF;
			else 
				sig_div <= sig_div + 1;			
			END IF;
		END IF;
	END PROCESS;
	
	process 
	begin 
		WAIT UNTIL RISING_EDGE(VSYNC);
		PacX <= PX; -- refreshes pacmans movemets on every new frame
		PacY <= PY;
	END PROCESS;
	
 -- stops outputting data on signal retrace period
RGB_OUT <= Colour_out when BLANK /= '1' else "00000000";

end Behavioral;
