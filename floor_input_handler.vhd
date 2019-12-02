----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:50:10 12/01/2019 
-- Design Name: 
-- Module Name:    floor_input_handler - Behavioral 
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

entity floor_input_handler is
    Port ( floor_in_clock : in  STD_LOGIC;
           --global_reset : in  STD_LOGIC;
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
end floor_input_handler;

architecture Behavioral of floor_input_handler is

--component sr_flip_flop
--	Port ( sr_clock : in  STD_LOGIC;
--			  S : in  STD_LOGIC;
--			  R : in  STD_LOGIC;
--			  --GLOBAL_RESET : in  STD_LOGIC;
--			  sr_out : inout  STD_LOGIC);
--
--end component;

component sr_mux is 
  Port ( sr_mux_clock : in STD_LOGIC;
			  S : in  STD_LOGIC;
			  cf0 : in  STD_LOGIC; 
			  cf1 : in  STD_LOGIC;
           e_door : in  STD_LOGIC;
           sr_mux_out : out  STD_LOGIC);
end component;

-- internal signals
--signal sr_u0_R, sr_u1_R, sr_d0_R, sr_d1_R : STD_LOGIC;
--
---- outputs
--signal sr_u0_temp_out, sr_u1_temp_out, sr_d0_temp_out, sr_d1_temp_out : STD_LOGIC;

begin

sr_mux_u0:sr_mux port map(
	sr_mux_clock => floor_in_clock,
	S => u0_in,
	cf1 => not(cf1),
	cf0 => not(cf0),
	e_door => door_opening,
	sr_mux_out => u0_out
);

sr_mux_u1:sr_mux port map(
	sr_mux_clock => floor_in_clock,
	S => u1_in,
	cf1 => not(cf1),
	cf0 => cf0,
	e_door => door_opening,
	sr_mux_out => u1_out
);

sr_mux_d0:sr_mux port map(
	sr_mux_clock => floor_in_clock,
	S => d0_in,
	cf1 => not(cf1),
	cf0 => cf0,
	e_door => door_opening,
	sr_mux_out =>d0_out
);

sr_mux_d1:sr_mux port map(
	sr_mux_clock => floor_in_clock,
	S => d1_in,
	cf1 => cf1,
	cf0 => not(cf0),
	e_door => door_opening,
	sr_mux_out => d1_out
);

--sr_u0_R <= not(cf1) and not(cf0) and door_opening;
--sr_u1_R <= not(cf1) and cf0 and door_opening;
--sr_d0_R <= not(cf1) and cf0 and door_opening;
--sr_d1_R <= cf1 and not(cf0) and door_opening;
--
--SR_u0_out:sr_flip_flop port map(
--	sr_clock => floor_in_clock,
--	S => u0_in,
--	R => sr_u0_R,
--	--GLOBAL_RESET => global_reset,
--	sr_out =>sr_u0_temp_out
--);
--
--SR_u1_out:sr_flip_flop port map(
--	sr_clock => floor_in_clock,
--	S => u1_in,
--	R => sr_u1_R,
--	--GLOBAL_RESET => global_reset,
--	sr_out =>sr_u1_temp_out
--);
--
--SR_d0_out:sr_flip_flop port map(
--	sr_clock => floor_in_clock,
--	S => d0_in,
--	R => sr_d0_R,
--	--GLOBAL_RESET => global_reset,
--	sr_out =>sr_d0_temp_out
--);
--
--SR_d1_out:sr_flip_flop port map(
--	sr_clock => floor_in_clock,
--	S => d1_in,
--	R => sr_d1_R,
--	--GLOBAL_RESET => global_reset,
--	sr_out =>sr_d1_temp_out
--);
--
--u0_out <= sr_u0_temp_out;
--u1_out <= sr_u1_temp_out;
--d0_out <= sr_d0_temp_out;
--d1_out <= sr_d1_temp_out;

end Behavioral;

