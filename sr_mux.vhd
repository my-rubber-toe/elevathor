----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:30:31 12/02/2019 
-- Design Name: 
-- Module Name:    sr_mux - Behavioral 
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

entity sr_mux is
    Port ( sr_mux_clock : in STD_LOGIC;
			  S : in  STD_LOGIC;
			  cf0 : in  STD_LOGIC; 
			  cf1 : in  STD_LOGIC;
           e_door : in  STD_LOGIC;
           sr_mux_out : out  STD_LOGIC);
end sr_mux;

architecture Behavioral of sr_mux is
component d_flip_flop is 
	Port(
			clock : in  STD_LOGIC;
           D : in  STD_LOGIC;
           R : in  STD_LOGIC;
           Q : out  STD_LOGIC
	);
end component;

component mux_2x1 is
	Port ( 
		m0 : in  STD_LOGIC;
		m1 : in  STD_LOGIC;
      sel : in  STD_LOGIC;
      mux_out : out  STD_LOGIC);
end component;

signal mux_D_out, q_1, mux_sr_in1 : STD_LOGIC;

begin

mux_sr_in1 <= not(cf0 and cf1 and e_door);

another_mux:mux_2x1 port map(
	m0 => S,
	m1 => mux_sr_in1,
	sel => q_1,
	mux_out => mux_D_out

);

D1:d_flip_flop port map(
	clock => sr_mux_clock,
	D => mux_D_out,
	R => not('0'),
	Q => q_1
);

sr_mux_out <= q_1;

end Behavioral;

