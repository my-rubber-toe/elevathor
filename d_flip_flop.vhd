----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:27:57 12/01/2019 
-- Design Name: 
-- Module Name:    d_flip_flop - Behavioral 
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

entity d_flip_flop is
    Port ( clock : in  STD_LOGIC;
           D : in  STD_LOGIC;
           R : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end d_flip_flop;

architecture Behavioral of d_flip_flop is

begin

process(clock) begin
	if(rising_edge(clock)) then 
		if(R = '1') then Q <= '0';
		else Q<= D;
		end if;
	end if;
end process;

end Behavioral;

