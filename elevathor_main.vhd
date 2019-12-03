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
			  system_h0 : in  STD_LOGIC;
			  system_h1 : in  STD_LOGIC;
			  system_h2 : in  STD_LOGIC;
			  system_alarm: in  STD_LOGIC;
			  system_alarm_reset : STD_LOGIC;
			  system_b0 : in STD_LOGIC;
			  system_b1 : in STD_LOGIC;
			  system_b2 : in STD_LOGIC;
			  system_u0 : in STD_LOGIC;
			  system_u1 : in STD_LOGIC;
			  system_d0 : in STD_LOGIC;
			  system_d1 : in STD_LOGIC;
			  system_close : in STD_LOGIC;
			  system_open : in STD_LOGIC;
			  system_is_closed : in STD_LOGIC;

			  -- floor module outs
           system_prev_out : out  STD_LOGIC;
			  system_dir_down : out  STD_LOGIC;
			  system_dir_up : out  STD_LOGIC;
			  system_enable_door : out  STD_LOGIC;
			  
			  -- door module outs
			  system_door_dir0 : out  STD_LOGIC;
			  system_door_dir1 : out  STD_LOGIC;
			  system_door_enable_delay : out  STD_LOGIC;
			  system_door_enable_floor : out  STD_LOGIC	  
	);
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

component button_marronazo is
    Port ( alarm_in : in  STD_LOGIC;
           b0_alarm_in : in  STD_LOGIC;
			  b1_alarm_in : in  STD_LOGIC;
			  b2_alarm_in : in  STD_LOGIC;
			  b0_in : in  STD_LOGIC;
			  b1_in : in  STD_LOGIC;
			  b2_in : in  STD_LOGIC;
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

-- hall_to_cf: internal signals
signal system_cf1, system_cf0 : STD_LOGIC;

-- alarm_module: internal signals
signal motor_enable_in, system_alarm_out, alarm_to_b0, alarm_to_b1, alarm_to_b2: STD_LOGIC;

-- internal signal, outputs from  button_marronazo
signal m_b0_out, m_b1_out, m_b2_out : STD_LOGIC;

-- internal signal, outputs from key conversion
signal key_conv_u0_out, key_conv_u1_out, key_conv_d0_out, key_conv_d1_out : STD_LOGIC;

-- floor_input_handler: internal signals
signal door_opening_in, floor_input_u0_out, floor_input_u1_out, floor_input_d0_out, floor_input_d1_out : STD_LOGIC;

-- internal signal, inputs and outputs from the floor_signal_handler
signal floor_signal_open_out, floor_signal_down_out, floor_signal_up_out : STD_LOGIC;

-- internal signals, floor_module outputs
signal floor_open_in, floor_prev_out, floor_dir_down_out, floor_dir_up_out, floor_enable_door_out : STD_LOGIC; 

-- internal signal, door_module
signal door_close_in, door_dir_1_out, door_dir_0_out, door_enable_delay_out, door_enable_floor_out : STD_LOGIC;

begin

thee_hall_effect:hall_to_cf_module port map(
	hall_clock => system_clock,
	hall_reset => '0',
	h0 => system_h0,
	h1 => system_h1,
   h2 => system_h2,
	cf1 => system_cf1,
	cf0 => system_cf0
);

--alarm_module, inputs signals
motor_enable_in <= floor_dir_up_out or floor_dir_down_out;

thee_alarm_module:alarm_module port map(
	alarm_clock => system_clock,
	alarm_reset => system_alarm_reset,
	alarm => system_alarm,
	cf1 => system_cf1,
	cf0 => system_cf0,
	motor_enable => motor_enable_in,
	dir => floor_dir_down_out, 
	alarm_out => system_alarm_out,
	b0_out => alarm_to_b0,
	b1_out => alarm_to_b1,
	b2_out => alarm_to_b2
);

thee_buttons_marronazo:button_marronazo port map(
	alarm_in =>system_alarm_out,
	b0_alarm_in => alarm_to_b0,
	b1_alarm_in => alarm_to_b1,
	b2_alarm_in => alarm_to_b2,
	b0_in => system_b0,
	b1_in => system_b1,
	b2_in => system_b2,
	b0_out => m_b0_out,
	b1_out => m_b1_out,
	b2_out => m_b2_out
);

thee_key_conversion_module:key_conversion_module port map(
	b0 => m_b0_out,
	b1 => m_b1_out,
	b2 => m_b2_out,
	u0 => system_u0,
	u1 => system_u1,
	d0 => system_d0,
	d1 => system_d1,
	cf0 => system_cf0,
	cf1 => system_cf1,
	u0_out => key_conv_u0_out,
	u1_out => key_conv_d1_out,
	d0_out => key_conv_d0_out,
	d1_out => key_conv_d1_out
);

-- floor_input dedicated input signal
door_opening_in <= not(door_dir_0_out) and door_dir_1_out;
thee_floor_input_handler:floor_input_handler port map(
	floor_in_clock => system_clock,
	cf0 => system_cf0,
	cf1 => system_cf1,
	door_opening => door_opening_in,
	u0_in => key_conv_u0_out,
	u1_in => key_conv_u1_out,
	d0_in => key_conv_d0_out,
	d1_in => key_conv_d1_out,
	u0_out => floor_input_u0_out,
	u1_out => floor_input_u1_out,
	d0_out => floor_input_d0_out,
	d1_out => floor_input_d1_out
);

thee_floor_signal_handler:floor_signal_handler_module port map(
	prev_dir => floor_prev_out, 
	cf1 => system_cf1,
	cf0 => system_cf0,
	u0_in => floor_input_u0_out,
	u1_in => floor_input_u1_out,
	d0_in => floor_input_d0_out,
	d1_in => floor_input_d1_out,
	open_door => floor_signal_open_out,
	down => floor_signal_down_out,
	up => floor_signal_up_out
);

--floor module input signal
floor_open_in <= system_open or floor_signal_open_out;

thee_floor_module:floor_module port map(
	floor_clock => system_clock,
	floor_reset => '0',
	floor_h0 => system_h0,
	floor_h1 => system_h1,
	floor_h2 => system_h2,
	floor_open => floor_open_in,
	floor_down => floor_signal_down_out,
	floor_up => floor_signal_up_out,
	floor_enable => door_enable_floor_out,
	floor_prev => floor_prev_out,
	floor_dir_up => floor_dir_up_out,
	floor_dir_down => floor_dir_down_out,
	floor_enable_door => floor_enable_door_out
);


-- door module input signal
door_close_in <= not(system_alarm_out) and system_close;

thee_door_module:door_module port map(
	door_clock => system_clock,
	door_reset => '0',
	enable_door => floor_enable_door_out,
	open_door => system_open,
	close_door => door_close_in, -- add the delay 
	is_closed => system_is_closed,
	dir_0 => door_dir_0_out,
	dir_1 => door_dir_1_out,
	enable_delay => door_enable_delay_out,
	enable_floor => door_enable_floor_out
);


end Behavioral;

