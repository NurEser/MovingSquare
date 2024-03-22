----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:31:53 05/13/2023 
-- Design Name: 
-- Module Name:    frequencydivider - Behavioral 
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
--use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity frequencydivider is
    Port ( clock : in  STD_LOGIC;
           frequencyenable : out  STD_LOGIC);
end frequencydivider;

architecture Behavioral of frequencydivider is

signal count : std_logic_vector(1 downto 0);

begin

process(clock)



begin

if (clock'event and clock = '1') then
	count <= count + "01";
end if;
if (count = "UU") then
	count <= "00";
end if;	
if (count = "11") then
frequencyenable <= '1';
else 
frequencyenable <= '0';
end if;
end process;



end Behavioral;

