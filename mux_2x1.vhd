----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:42:07 12/01/2019 
-- Design Name: 
-- Module Name:    mux_2x1 - Behavioral 
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

entity mux_2x1 is
    Port ( m0 : in  STD_LOGIC;
           m1 : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           mux_out : out  STD_LOGIC);
end mux_2x1;

architecture Behavioral of mux_2x1 is

begin

mux_out <= m0 when(sel='0') else
			  m1 when(sel = '1');
			

end Behavioral;
