----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:02:17 12/01/2019 
-- Design Name: 
-- Module Name:    floor_signal_handler_module - Behavioral 
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

entity floor_signal_handler_module is
    Port ( prev_dir : in  STD_LOGIC;
           cf1 : in  STD_LOGIC;
           cf0 : in  STD_LOGIC;
           u0_in : in  STD_LOGIC;
           u1_in : in  STD_LOGIC;
           d0_in : in  STD_LOGIC;
           d1_in : in  STD_LOGIC;
           open_door : out  STD_LOGIC;
           down : out  STD_LOGIC;
           up : out  STD_LOGIC);
end floor_signal_handler_module;

architecture Behavioral of floor_signal_handler_module is

component mux_8x1 is 
	Port ( 
		m0 : in  STD_LOGIC;
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
		mux_out : out  STD_LOGIC);
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

-- internal ignals
signal mux_open_m1, mux_open_m5, mux_down_m2, mux_up_m0 : STD_LOGIC;

begin

mux_open_m1 <= u1_in or (d0_in and not(d1_in));
mux_open_m5 <= d0_in or (u1_in and not(u0_in));

mux_down_m2 <= u0_in or u1_in or d0_in;

mux_up_m0 <= u1_in or d0_in or d1_in;

MUX_OPEN:mux_8x1 port map(
	m0 =>  u0_in,
	m1 => mux_open_m1,
	m2 => d1_in,
	m3 => '1',
	m4 => u0_in,
	m5 => mux_open_m5,
	m6 => d1_in,
	m7 => '1',
	s0 => cf0,
	s1 => cf1,
	s2 => prev_dir,
	mux_out => open_door

);

MUX_DOWN:mux_4x1 port map(
	m0 => '1',
   m1 => u0_in,
   m2 => mux_down_m2,
   m3 => '1',
   s0 => cf0,
   s1 => cf1,
   mux_out => down
);

MUX_UP:mux_4x1 port map(
	m0 => mux_up_m0,
   m1 => d1_in,
   m2 => '1',
   m3 => '1',
   s0 => cf0,
   s1 => cf1,
   mux_out => up
);

end Behavioral;

