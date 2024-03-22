----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:22:00 06/06/2023 
-- Design Name: 
-- Module Name:    newsquareposition - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity newsquareposition is
	port(
		Clock    : in  STD_LOGIC;
		slow_enable : in  STD_LOGIC;
		x_new      : out integer ;
		y_new      : out integer;
		color  : out STD_LOGIC_VECTOR(7 downto 0);
		backcolor : out STD_LOGIC_VECTOR(7 downto 0)
	);
end newsquareposition;


architecture Behavioral of newsquareposition is

signal colorcount : integer range 0 to 50 := 0;
signal x_pos : integer range 140 to 740 := 367;
signal y_pos : integer range 25 to 465 := 259;
--signal count 	: STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
signal object_color  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal back_color  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin

	process(clock)
	--variable x_pos		 : integer := 320; --range 144 to 734 := 320;
   --variable y_pos		 : integer := 240; --range 31 to 461 := 240;
	variable direction : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');

	
	begin
		
		if(clock'event and clock ='1' and slow_enable ='1') then 
					if (direction = "UU") then
						direction:= "00";
					end if;
					if (object_color = "UUUUUUUU") then
						object_color<= "00000001";
					end if;

					--if (x_pos = u) then
						--x_pos:= 150;
					--end if;
				--	if (y_pos = u) then
					--	y_pos := 150;
					--end if;
					
					
					if ((x_pos = 144) or (x_pos = 734)) then
						case direction is
						when "00"   => direction := "01"; back_color <= "00011111";
						when "01"   => direction := "00"; back_color <= "01100011";
						when "10"   => direction := "11"; back_color <= "00011111";
						when others => direction := "10"; back_color <= "01100011";
						end case;
					end if;
					
					if ((y_pos = 31) or (y_pos = 461)) then
						case direction is
						when "00"   => direction := "10"; back_color <= "11110000";
						when "01"   => direction := "11"; back_color <= "11110000";
						when "10"   => direction := "00"; back_color <= "01111110";
						when others => direction := "01"; back_color <= "01111110";
						end case;
					end if;
					
					
					case direction is
					when "00"   => x_pos <= x_pos - 1; y_pos <= y_pos + 1; colorcount <= colorcount +1 ;
					when "01"   => x_pos <= x_pos + 1; y_pos <= y_pos + 1; colorcount <= colorcount +1;
					when "10"   => x_pos <= x_pos - 1; y_pos <= y_pos - 1; colorcount <= colorcount +1;
					when others => x_pos <= x_pos + 1; y_pos <= y_pos - 1; colorcount <= colorcount +1;
					end case;
					
					if(colorcount = 50) then 
					object_color <= object_color +1;
					colorcount <= 0;
					end if;
					--count <= (others => '0');
				--x_pos <=  x_pos-10;
				--y_pos <= y_pos-10;
		end if;
		
		x_new <= x_pos;
		y_new <= y_pos;
		color <= object_color;
		backcolor <= back_color;
end process;
-- x <= 320;
-- y <= 240;
end Behavioral;
