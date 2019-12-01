----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:59:20 12/01/2019 
-- Design Name: 
-- Module Name:    door_module - Behavioral 
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

entity door_module is
    Port ( 
		door_clock : in  STD_LOGIC;
		door_reset : in  STD_LOGIC;
      enable_door : in  STD_LOGIC;
      open_door : in  STD_LOGIC;
      close_door : in  STD_LOGIC;
		is_closed : in  STD_LOGIC;
		dir_0 : out  STD_LOGIC;
		dir_1 : out  STD_LOGIC;
		enable_delay : out  STD_LOGIC;
		enable_floor : out  STD_LOGIC
	);
end door_module;

architecture Behavioral of door_module is

component d_flip_flop is 
	Port(
			clock : in  STD_LOGIC;
           D : in  STD_LOGIC;
           R : in  STD_LOGIC;
           Q : out  STD_LOGIC
	);
end component;

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


-- internal signals
-- muxes
signal mux_A_out, mux_B_out, mux_A_m3 : STD_LOGIC;
signal q_A, q_B : STD_LOGIC;

begin

mux_A_m3 <= not(is_closed) and not(open_door);

door_d_flip_flop_A:d_flip_flop port map(
	clock=> door_clock, 
   D => mux_A_out,
   R => not(door_reset),
   Q => q_A
);

door_d_flip_flop_B:d_flip_flop port map(
	clock=> door_clock, 
   D => mux_B_out,
   R => not(door_reset),
   Q => q_B
);

door_mux_A:mux_4x1 port map(
	m0 => '0',
	m1 => '1',
   m2 => '1',
	m3 => mux_A_m3,
	s0 => q_B,
	s1 => q_A,
	mux_out => mux_A_out

);

door_mux_B:mux_4x1 port map(
	m0 => enable_door,
	m1 => '0',
   m2 => close_door,
	m3 => not(is_closed),
	s0 => q_B,
	s1 => q_A,
	mux_out => mux_B_out
);

-- outputs
dir_0 <= q_A and q_B;
dir_1 <= q_A and not(q_B);
enable_delay <= not(q_A) and q_B;
enable_floor <= not(q_A) and not(q_B);


end Behavioral;

