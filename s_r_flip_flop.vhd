----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:07:02 12/01/2019 
-- Design Name: 
-- Module Name:    s_r_flip_flop - Behavioral 
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

entity sr_flip_flop is
    Port ( sr_clock : in  STD_LOGIC;
           S : in  STD_LOGIC;
           R : in  STD_LOGIC;
           --GLOBAL_RESET : in  STD_LOGIC;
           sr_out : inout  STD_LOGIC);
end sr_flip_flop;

architecture Behavioral of sr_flip_flop is

--component d_flip_flop is 
--	Port(
--			clock : in  STD_LOGIC;
--           D : in  STD_LOGIC;
--           R : in  STD_LOGIC;
--           Q : out  STD_LOGIC
--	);
--end component;

-- inernal signals
--signal or_out, and1_out, and2_out, and3_out : STD_LOGIC;

begin

--and1_out <= sr_out and not(R);
--and2_out <= sr_out and S;
--and3_out <= not(R) and S;

--or_out <= and1_out or and2_out or and3_out;

--d_internal:d_flip_flop port map(
--	clock => sr_clock,
--	D => or_out,
--	R => not(GLOBAL_RESET),
--	Q => sr_out
--);

process (sr_clock)
variable tmp: std_logic;
begin
if(rising_edge(sr_clock)) then
	if(S='0' and R='0')then
		tmp:=tmp;
	elsif(S='0' and R='1')then
		tmp:='0';
	else
		tmp:='1';
	end if;
end if;
sr_out <= tmp;
end process;







end Behavioral;

