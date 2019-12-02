----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:20:18 12/01/2019 
-- Design Name: 
-- Module Name:    floor_module - Behavioral 
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

entity floor_module is
    Port ( floor_clock : in  STD_LOGIC;
           floor_reset : in  STD_LOGIC;
           floor_h0 : in  STD_LOGIC;
           floor_h1 : in  STD_LOGIC;
           floor_h2 : in  STD_LOGIC;
           floor_open : in  STD_LOGIC;
           floor_down : in  STD_LOGIC;
           floor_up : in  STD_LOGIC;
           floor_enable : in  STD_LOGIC;
           floor_prev : out  STD_LOGIC;
           floor_dir_up : out  STD_LOGIC;
           floor_dir_down : out  STD_LOGIC;
           floor_enable_door : out  STD_LOGIC);
end floor_module;

architecture Behavioral of floor_module is

component d_flip_flop is 
Port ( clock : in  STD_LOGIC;
           D : in  STD_LOGIC;
           R : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end component;

component mux_16x1 is 
Port ( m0 : in  STD_LOGIC;
           m1 : in  STD_LOGIC;
           m2 : in  STD_LOGIC;
           m3 : in  STD_LOGIC;
           m4 : in  STD_LOGIC;
           m5 : in  STD_LOGIC;
           m6 : in  STD_LOGIC;
           m7 : in  STD_LOGIC;
           m8 : in  STD_LOGIC;
           m9 : in  STD_LOGIC;
           m10 : in  STD_LOGIC;
           m11 : in  STD_LOGIC;
           m12 : in  STD_LOGIC;
           m13 : in  STD_LOGIC;
           m14 : in  STD_LOGIC;
           m15 : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           s1 : in  STD_LOGIC;
           s2 : in  STD_LOGIC;
           s3 : in  STD_LOGIC;
           mux_out : out  STD_LOGIC);
end component;

-- internal signals
signal mux_A_out, mux_B_out, mux_C_out, mux_D_out : STD_LOGIC;
signal q_A, q_B, q_C, q_D : STD_LOGIC;

signal mux_A_m0, mux_A_m1, mux_A_m13, mux_A_m15, mux_B_m0, mux_B_m13, mux_C_m1, mux_C_m13, mux_D_m1, mux_D_m13: STD_LOGIC;


begin

mux_A_m0 <= not(floor_open) and floor_up;
mux_A_m1 <= floor_down and not(floor_open) and not(floor_up);
mux_A_m13 <= not(floor_up) or floor_down or floor_open;
mux_A_m15 <= not(floor_down) or floor_open;
mux_B_m0 <= floor_open or floor_up;
mux_B_m13 <= not(floor_up) and not(floor_down) and not(floor_open);
mux_C_m1 <= floor_up and not(floor_open);
mux_C_m13 <=  floor_up and not(floor_down) and not(floor_open);
mux_D_m1 <= not(floor_down and not(floor_open) and not(floor_up));
mux_D_m13 <= not(floor_down) or floor_open;

floor_SA:d_flip_flop port map(
	clock => floor_clock,
   D => mux_A_out,
   R => not(floor_reset),
   Q => q_A
);

floor_SB:d_flip_flop port map(
	clock => floor_clock,
   D => mux_B_out,
   R => not(floor_reset),
   Q => q_B
);

floor_SC:d_flip_flop port map(
	clock => floor_clock,
   D => mux_C_out,
   R => not(floor_reset),
   Q => q_C
);

floor_SD:d_flip_flop port map(
	clock => floor_clock,
   D => mux_D_out,
   R => not(floor_reset),
   Q => q_D
);


mux_A_16x1:mux_16x1 port map(
	m0 => mux_A_m0,
   m1 => mux_A_m1,
   m2 => '0',
   m3 => floor_h2,
   m4 => '0',
   m5 => '0',
   m6 => '0',
   m7 => floor_h1,
   m8 => not(floor_h0),
   m9 => '1',
   m10 => '0',
   m11 => '1',
	m12 => not(floor_h1),
	m13 => mux_A_m13,
	m14 => '0',
	m15 => mux_A_m15,
	s0 => q_D,
	s1 => q_C,
	s2 => q_B,
	s3 => q_A,
	mux_out => mux_A_out
);

mux_B_16x1:mux_16x1 port map(
	m0 => mux_B_m0,
   m1 => floor_open,
   m2 => '0',
   m3 => floor_h2,
   m4 => not(floor_enable),
   m5 => not(floor_enable),
   m6 => '0',
   m7 => '1',
   m8 => '0',
   m9 => floor_enable,
   m10 => '0',
   m11 => floor_enable,
	m12 => not(floor_h1),
	m13 => mux_B_m13,
	m14 => '0',
	m15 => not(floor_open),
	s0 => q_D,
	s1 => q_C,
	s2 => q_B,
	s3 => q_A,
	mux_out => mux_B_out
);

mux_C_16x1:mux_16x1 port map(
	m0 => '0',
   m1 => mux_C_m1,
   m2 => '0',
   m3 => '1',
   m4 => '0',
   m5 => '0',
   m6 => '0',
   m7 => not(floor_h1),
   m8 => '0',
   m9 => '0',
   m10 => '0',
   m11 => '1',
	m12 => '0',
	m13 => mux_C_m13,
	m14 => '0',
	m15 => '1',
	s0 => q_D,
	s1 => q_C,
	s2 => q_B,
	s3 => q_A,
	mux_out => mux_C_out
);

mux_D_16x1:mux_16x1 port map(
	m0 => '0',
   m1 => mux_D_m1,
   m2 => '0',
   m3 => '1',
   m4 => '0',
   m5 => '1',
   m6 => '0',
   m7 => '1',
   m8 => '0',
   m9 => '1',
   m10 => '0',
   m11 => '1',
	m12 => floor_h1,
	m13 => mux_D_m13,
	m14 => '0',
	m15 => '1',
	s0 => q_D,
	s1 => q_C,
	s2 => q_B,
	s3 => q_A,
	mux_out => mux_D_out
);

--outputs
floor_prev <= q_A;
floor_dir_down <= (q_A and not(q_B) and not(q_C) and not(q_D)) or (q_D and q_C and q_B and not(q_A));
floor_dir_up <= (q_D and q_C and not(q_B) and not(q_A)) or (q_A and q_B and not(q_C) and not(q_D));
floor_enable_door <= ((q_D and q_B and q_A) or (not(q_A) and not(q_B) and not(q_C))) and floor_open;


end Behavioral;

