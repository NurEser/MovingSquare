----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:24:22 06/06/2023 
-- Design Name: 
-- Module Name:    slow_freqdivider - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity slow_freqdivider is
    Port ( clock : in  STD_LOGIC;
           slow_enable : out  STD_LOGIC);
end slow_freqdivider;

architecture Behavioral of slow_freqdivider is

signal count : integer range 0 to 833330 := 0; --416666 := 0;

begin
process(clock)



begin

if (clock'event and clock = '1') then
	count <= count + 1;
	if (count = 833329) then
	slow_enable <= '1';
	count <= 0;
	else 
	slow_enable <= '0';
	end if;

end if;

end process;




end Behavioral;

