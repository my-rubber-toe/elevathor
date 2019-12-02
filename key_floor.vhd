----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:33:43 12/02/2019 
-- Design Name: 
-- Module Name:    key_floor - Behavioral 
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

entity key_floor is
    Port ( system_clock : in STD_LOGIC;
			  cf1: in STD_LOGIC;
			  cf0 : in  STD_LOGIC;
			  d_open : in STD_LOGIC;
			  key_b0_in : in  STD_LOGIC;
           key_b1_in : in  STD_LOGIC;
           key_b2_in : in  STD_LOGIC;
           floor_u0_out : out  STD_LOGIC;
           floor_u1_out : out  STD_LOGIC;
           floor_d0_out : out  STD_LOGIC;
			  floor_d1_out : out  STD_LOGIC;
			  cf0_out : out  STD_LOGIC;
			  cf1_out : out  STD_LOGIC);
end key_floor;

architecture Behavioral of key_floor is

component floor_input_handler is 
 Port ( floor_in_clock : in  STD_LOGIC;
           cf0 : in  STD_LOGIC;
           cf1 : in  STD_LOGIC;
           door_opening : in  STD_LOGIC;
           u0_in : in  STD_LOGIC;
           u1_in : in  STD_LOGIC;
           d0_in : in  STD_LOGIC;
           d1_in : in  STD_LOGIC;
           u0_out : out  STD_LOGIC;
           u1_out : out  STD_LOGIC;
           d0_out : out  STD_LOGIC;
           d1_out : out  STD_LOGIC);
end component;

component key_conversion_module is
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
end component;

signal kcm_out_u0, kcm_out_u1, kcm_out_d0, kcm_out_d1 : STD_LOGIC;

begin

cf0_out <= cf0;
cf1_out <= cf1;

kcm:key_conversion_module port map(
b0 => key_b0_in,
b1 => key_b1_in,
b2 => key_b2_in,
u0 => '0',
u1 => '0',
d0 => '0',
d1 => '0',
cf0 => cf0,
cf1 => cf1,
u0_out => kcm_out_u0,
u1_out => kcm_out_u1,
d0_out => kcm_out_d0,
d1_out => kcm_out_d1
);

fih: floor_input_handler port map(
	floor_in_clock => system_clock,
   cf0 => cf0,
   cf1 => cf1,
	door_opening => d_open,
	u0_in => kcm_out_u0,
   u1_in => kcm_out_u1,
	d0_in => kcm_out_d0,
	d1_in => kcm_out_d1,
	u0_out => floor_u0_out,
	u1_out => floor_u1_out,
	d0_out => floor_d0_out,
	d1_out => floor_d1_out
);


end Behavioral;

