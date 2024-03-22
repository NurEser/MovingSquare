----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:03:47 05/13/2023 
-- Design Name: 
-- Module Name:    colorgenerator - Behavioral 
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
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity colorgenerator is
    Port ( clock : in  STD_LOGIC;
           enable : in  STD_LOGIC;
			  obje_color : in std_logic_vector(7 downto 0);
			  back_color : in std_logic_vector(7 downto 0);
			  --reset : in std_logic;
           --x_pixel : in  STD_LOGIC_vector(9 downto 0);
			  --y_pixel : in std_logic_vector(9 downto 0); 
			  x_object : in integer;
			  y_object : in integer;
			  x_pixel : in integer;
			  y_pixel : in integer;
			  vid_enable : in std_logic;
           red : out  STD_LOGIC_VECTOR (2 downto 0);
           green : out  STD_LOGIC_VECTOR (2 downto 0);
           blue : out  STD_LOGIC_VECTOR (1 downto 0));
end colorgenerator;

architecture Behavioral of colorgenerator is

signal colorcount : std_logic_vector(7 downto 0);

begin

process(clock)
variable x_object_left : integer ;
variable x_object_right : integer ;
variable y_object_up : integer ;
variable y_object_down : integer ;
begin

x_object_left := x_object;
x_object_right := x_object +50;
y_object_up := y_object;
y_object_down := y_object + 50;

if (clock'event and clock = '1' and enable = '1') then
	if (vid_enable = '0') then
		colorcount <= "00000000";
	elsif (vid_enable = '1') then
		if((x_object_left < x_pixel) and ( x_object_right > x_pixel) and (y_object_up < y_pixel) and (y_pixel < y_object_down)) then
			colorcount <= obje_color;
		else
			colorcount <= back_color;
	   end if;
	end if;
end if;
end process;
red <= colorcount(7 downto 5);
green <= colorcount(4 downto 2);
blue <= colorcount(1 downto 0);



end Behavioral;

