----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:04:45 12/02/2019 
-- Design Name: 
-- Module Name:    elevathor_main - Behavioral 
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

entity elevathor_main is
    Port ( system_clock : in  STD_LOGIC;
           someout : out  STD_LOGIC);
end elevathor_main;

architecture Behavioral of elevathor_main is

component hall_to_cf_module is
	Port (hall_clock : in  STD_LOGIC;
			  hall_reset : in  STD_LOGIC;
           h0 : in  STD_LOGIC;
           h1 : in  STD_LOGIC;
           h2 : in  STD_LOGIC;
           cf1 : out  STD_LOGIC;
           cf0 : out  STD_LOGIC);
end component;

component alarm_module is 
	Port ( alarm_clock : in  STD_LOGIC;
           alarm_reset : in  STD_LOGIC;
           alarm : in  STD_LOGIC;
           cf1 : in  STD_LOGIC;
           cf0 : in  STD_LOGIC;
           motor_enable : in  STD_LOGIC;
           dir : in  STD_LOGIC;
           alarm_out : out  STD_LOGIC;
           b0_out : out  STD_LOGIC;
           b1_out : out  STD_LOGIC;
           b2_out : out  STD_LOGIC);
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

component floor_signal_handler_module is 
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
end component;

component floor_module is 
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
end component;

component door_module is
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
end component;


begin


end Behavioral;

