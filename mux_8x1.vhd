----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:48:59 12/01/2019 
-- Design Name: 
-- Module Name:    mux_8x1 - Behavioral 
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

entity mux_8x1 is
    Port ( m0 : in  STD_LOGIC;
           m1 : in  STD_LOGIC;
           m2 : in  STD_LOGIC;
           m3 : in  STD_LOGIC;
           m4 : in  STD_LOGIC;
           m5 : in  STD_LOGIC;
           m6 : in  STD_LOGIC;
           m7 : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           s2 : in  STD_LOGIC;
           mux_8x1_out : out  STD_LOGIC);
end mux_8x1;

architecture Behavioral of mux_8x1 is

begin

mux_8x1_out <= m0 when(s2='0' and s1='0' and s0='0') else
			  m1 when(s2='0' and s1='0' and s0='1') else
			  m2 when(s2='0' and s1='1' and s0='0') else
			  m3 when(s2='0' and s1='1' and s0='1') else
			  m4 when(s2='1' and s1='0' and s0='0') else
			  m5 when(s2='1' and s1='0' and s0='1') else
			  m6 when(s2='1' and s1='1' and s0='0') else
			  m7 when(s2='1' and s1='1' and s0='1');

end Behavioral;

