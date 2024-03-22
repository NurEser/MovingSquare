----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:39:45 05/13/2023 
-- Design Name: 
-- Module Name:    vertical_sync_gen - Behavioral 
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

entity vertical_sync_gen is
    Port ( clock : in  STD_LOGIC;
           enable : in  STD_LOGIC;
			  freqenable : in std_logic;
			  --y : out std_logic_vector(9 downto 0);
			  y : out integer;
			  vid_enable : out std_logic;
           Vsync : out  STD_LOGIC);
end vertical_sync_gen;

architecture Behavioral of vertical_sync_gen is

signal reset : std_logic := '0';


constant Ts : integer := 521;
constant Tpw     : integer := 2;
constant Tfp     : integer := 10;
constant Tbp      : integer := 29;

begin

process(clock)
variable ycount: std_logic_vector(9 downto 0);
variable count: integer range 1 to Ts := 1;
begin 
if(clock'event and clock = '1' and enable ='1' and freqenable ='1') then 
	if Reset = '1' then
				count := 1;
				--ycount :="0000000000";
	else 	count := count + 1;
	end if;
end if;
if count = Ts then
	Reset <= '1';
	--ycount :="0000000001";

else
	Reset <= '0';
end if;
if ((Tpw + Tbp) < count and count < (Ts - Tfp)) then
			vid_enable <= '1';
			--ycount := ycount + "0000000001";

		else
			vid_enable <= '0';
		end if;
if Tpw < count then
	Vsync <= '1';
else
	Vsync <= '0';
end if;

--if(clock'event and clock ='1' and ((Tpw+ Tbp) < count ) and (count < (Ts - Tfp)) and enable = '1' and freqenable ='1') then 
	--ycount := ycount + "0000000001";
	--end if;
y <= count;
end process;
end Behavioral;

