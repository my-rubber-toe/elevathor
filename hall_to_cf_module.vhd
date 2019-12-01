----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:27:00 12/01/2019 
-- Design Name: 
-- Module Name:    hall_to_cf_module - Behavioral 
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

entity hall_to_cf_module is
    Port ( hall_reset : in  STD_LOGIC;
           h0 : in  STD_LOGIC;
           h1 : in  STD_LOGIC;
           h2 : in  STD_LOGIC;
           hall_clock : in  STD_LOGIC;
           cf1 : out  STD_LOGIC;
           cf0 : out  STD_LOGIC);
end hall_to_cf_module;

architecture Behavioral of hall_to_cf_module is
component mux_4x1 is 
	Port ( 
		m0 : in  STD_LOGIC;
      m1 : in  STD_LOGIC;
      m2 : in  STD_LOGIC;
      m3 : in  STD_LOGIC;
      s0 : in  STD_LOGIC;
      s1 : in  STD_LOGIC;
      mux_out : out  STD_LOGIC
	);
end component;

component d_flip_flop is 
	Port(
			clock : in  STD_LOGIC;
           D : in  STD_LOGIC;
           R : in  STD_LOGIC;
           Q : out  STD_LOGIC
	);
end component;

-- internal signals
signal mux_A_out, mux_B_out : STD_LOGIC;
signal q_A, q_B : STD_LOGIC;

signal mux_B_m1 : STD_LOGIC;



begin

mux_B_m1 <= not(h0) and not(h2);

hall_d_flip_flop_A:d_flip_flop port map(
	clock=> hall_clock, 
   D => mux_A_out,
   R => not(hall_reset),
   Q => q_A
);

hall_d_flip_flop_B:d_flip_flop port map(
	clock=> hall_clock, 
   D => mux_B_out,
   R => not(hall_reset),
   Q => q_B
);

hall_mux_A:mux_4x1 port map(
	m0 => '0',
	m1 => h2,
   m2 => not(h1),
   m3 => '0',
   s0 => q_B,
   s1 => q_A,
   mux_out => mux_A_out
);

hall_mux_B:mux_4x1 port map(
	m0 => h1,
	m1 => mux_B_m1,
   m2 => h1,
   m3 => '0',
   s0 => q_B,
   s1 => q_A,
   mux_out => mux_A_out
);

-- outputs
cf1 <= q_A;
cf0 <= q_B;





end Behavioral;

