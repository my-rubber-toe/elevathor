----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:55:45 12/01/2019 
-- Design Name: 
-- Module Name:    alarm_module - Behavioral 
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

entity alarm_module is
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
end alarm_module;

architecture Behavioral of alarm_module is

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

signal mux_alarm_out, alarm_D_out : STD_LOGIC;

begin

alarm_mux:mux_2x1 port map(
	m0 => alarm,
	m1 => not(alarm_reset),
   sel => alarm_D_out,
   mux_out => mux_alarm_out
);

alarm_D:d_flip_flop port map(
	clock => alarm_clock,
	D => mux_alarm_out,
	R => not(alarm_reset),
	Q => alarm_D_out
);
-- output
alarm_out <= alarm_D_out;
b0_out <= alarm_D_out and ((not(cf1) and not(cf0)) or (motor_enable and not(dir) and not(cf1)));
b1_out <= alarm_D_out and ((not(motor_enable) and cf0) or (motor_enable and not(dir) and cf1) or (motor_enable and(dir) and not(cf1) and not(cf0)));
b2_out <= alarm_D_out and ((not(motor_enable) and cf1) or (motor_enable and dir and cf0) or (dir and cf1));


end Behavioral;

