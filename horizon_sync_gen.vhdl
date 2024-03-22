----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:18:33 05/13/2023 
-- Design Name: 
-- Module Name:    horizon_sync_gen - Behavioral 
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

entity horizon_sync_gen is
    Port ( clock : in  STD_LOGIC;
           enable : in  STD_LOGIC;
			  --x : out std_logic_vector(9 downto 0);
			  x : out integer;
           HSYNC : out  STD_LOGIC;
			  vid_enable : out std_logic;
           vertical_enable : out  STD_LOGIC);
end horizon_sync_gen;

architecture Behavioral of horizon_sync_gen is

signal reset : std_logic := '0';

constant Ts : integer := 800;
constant Tpw     : integer := 96;
constant Tfp     : integer := 16;
constant Tbp      : integer := 48; 


begin


process(clock)
variable count : integer range 1 to Ts :=1;
--variable xcount : std_logic_vector(9 downto 0) :="0000000000";
begin 

if(clock'event and clock ='1' and enable ='1') then 
	if(reset= '1') then 
		count := 1;
		--xcount := "0000000000";
	else count := count +1;
	end if;
	if (count = Ts) then 
	vertical_enable <= '1';
	Reset <= '1';
	--xcount := "0000000001";

	else
	vertical_enable <= '0';
	Reset <= '0';
	end if;
end if;


if(((Tpw+ Tbp) < count ) and (count < (Ts - Tfp) )) then 
	vid_enable <= '1';
	--xcount := xcount + "0000000001";
else 
  vid_enable <= '0';
end if;

if Tpw < count then
	HSYNC <= '1';
	else
	HSYNC <= '0';
end if;

--if(clock'event and clock ='1' and ((Tpw+ Tbp) < count ) and (count < (Ts - Tfp)) and enable = '1') then 
--	xcount := xcount + "0000000001";
--end if;

x <= count;
end process;

end Behavioral;

