----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:18:10 12/01/2019 
-- Design Name: 
-- Module Name:    key_conversion_module - Behavioral 
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

entity key_conversion_module is
    Port ( b0 : in  STD_LOGIC;
           b1 : in  STD_LOGIC;
           b2 : in  STD_LOGIC;
           u0 : in  STD_LOGIC;
           u1 : in  STD_LOGIC;
           d0 : in  STD_LOGIC;
           d1 : in  STD_LOGIC;
           cf0 : in  STD_LOGIC;
           cf1 : in  STD_LOGIC;
           u0_out : out  STD_LOGIC;
           u1_out : out  STD_LOGIC;
           d0_out : out  STD_LOGIC;
           d1_out : out  STD_LOGIC);
end key_conversion_module;

architecture Behavioral of key_conversion_module is

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
signal mux_A_out, mux_B_out, mux_C_out, mux_D_out : STD_LOGIC;


begin

key_mux_A:mux_4x1 port map(
	m0 => '0',
	m1 => b0,
   m2 => b0,
   m3 => '0',
   s0 => cf0,
   s1 => cf1,
   mux_out => mux_A_out
);

key_mux_B:mux_4x1 port map(
	m0 => b1,
	m1 => '0',
   m2 => '0',
   m3 => '0',
   s0 => cf0,
   s1 => cf1,
   mux_out => mux_B_out
);

key_mux_C:mux_4x1 port map(
	m0 => '0',
	m1 => '0',
   m2 => b1,
   m3 => '0',
   s0 => cf0,
   s1 => cf1,
   mux_out => mux_B_out
);

key_mux_D:mux_4x1 port map(
	m0 => b2,
	m1 => b2,
   m2 => '0',
   m3 => '0',
   s0 => cf0,
   s1 => cf1,
   mux_out => mux_D_out
);

-- outputs

u0_out <= mux_A_out or u0;
u1_out <= mux_B_out or u1;
d0_out <= mux_C_out or d0;
d1_out <= mux_D_out or d1;

end Behavioral;

