----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:54:32 05/13/2023 
-- Design Name: 
-- Module Name:    topdesign - Behavioral 
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity topdesign is
    Port ( clock : in  STD_LOGIC;
			  --x : out integer;
			  --y : out integer;
			 -- x_obje : out integer;
			  --y_obje : out integer;
			  --video: out std_logic ;
           vsync : out  STD_LOGIC;
           hsync : out  STD_LOGIC;
           red : out  STD_LOGIC_VECTOR (2 downto 0);
           green : out  STD_LOGIC_VECTOR (2 downto 0);
           blue : out  STD_LOGIC_VECTOR (1 downto 0));
end topdesign;

architecture Behavioral of topdesign is

component frequencydivider is
	port (
		clock   : in  STD_LOGIC;
		frequencyenable : out STD_LOGIC
	);
end component;

component slow_freqdivider is
    Port ( clock : in  STD_LOGIC;
           slow_enable : out  STD_LOGIC);
end component;


component colorgenerator is
	port (
		clock : in  STD_LOGIC;
		enable  : in  STD_LOGIC;
		obje_color : in std_logic_vector(7 downto 0);
		back_color : in std_logic_vector(7 downto 0);
		x_object: in integer;
		y_object : in integer;
		x_pixel : in integer;
		y_pixel : in integer;
		vid_enable : in std_logic;
		red    : out STD_LOGIC_VECTOR(2 downto 0);
		green  : out STD_LOGIC_VECTOR(2 downto 0);
		blue   : out STD_LOGIC_VECTOR(1 downto 0)
	);
end component;

component horizon_sync_gen is
	 port (
		 Clock         : in  STD_LOGIC;
		 Enable      : in  STD_LOGIC;
		 x : out integer;		 
		 Hsync      : out STD_LOGIC;
		 vid_enable : out STD_LOGIC;
		 Vertical_enable    : out STD_LOGIC
	 );
end component;

component vertical_sync_gen is
	 port (
		 Clock         : in  STD_LOGIC;
		 Enable      : in  STD_LOGIC;
		 freqenable : in std_logic;
		 y : out integer;
		 vid_enable : out STD_LOGIC;
		 Vsync      : out STD_LOGIC
		 
	 );
end component;

component newsquareposition is
	port(
		Clock    : in  STD_LOGIC;
		slow_enable : in  STD_LOGIC;
		x_new      : out integer ;
		y_new      : out integer;
		color  : out STD_LOGIC_VECTOR(7 downto 0);
		backcolor : in std_logic_vector(7 downto 0)

	);
end component;


signal clk_en, v_enable,slow_en: std_logic;
signal video_enable : STD_LOGIC;
signal h_vid_enable, v_vid_enable : std_logic;
signal count, obj_color ,backcol : STD_LOGIC_VECTOR(7 downto 0);
signal x_pix : integer;
signal y_pix :integer;
signal x_obj, y_obj :integer;


begin
	--reset <= '0';
	a1 : frequencydivider port map( clock, clk_en);
	
	b1: slow_freqdivider port map(clock,slow_en);
	
	a2 : horizon_sync_gen port map(clock, clk_en,x_pix, hsync,h_vid_enable, v_enable);
	
	a3 : vertical_sync_gen	port map(clock, v_enable, clk_en,y_pix, v_vid_enable,vsync);
	
	b2: newsquareposition port map(clock, slow_en, x_obj, y_obj, obj_color,backcol);

	video_enable <= h_vid_enable and v_vid_enable;

	a4 : colorgenerator port map(clock, clk_en, obj_color, backcol, x_obj, y_obj, x_pix, y_pix, video_enable, red, green, blue);
--video <= video_enable;
--x<= x_pix;
--y<= y_pix;
--x_obje<= x_object;
--y_obje <= y_object;
end Behavioral ;

