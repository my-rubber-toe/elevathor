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

-- internal signals
signal DX_out, DY_out, DZ_out, DA_out, DB_out : STD_LOGIC;
signal DZ_in, DA_in, DB_in : STD_LOGIC;

begin

DZ_in <= (not(DX_out) and DZ_out) or DY_out;

DA_in <= DZ_out and ((cf1 and not(motor_enable)) or (cf0 and dir and motor_enable));
DB_in <= DZ_out and (motor_enable xor cf0);

DX:d_flip_flop port map(
	clock => alarm_clock,
	D => alarm_reset,
	R => not(alarm_reset),
	Q => DX_out
);

DY:d_flip_flop port map(
	clock => alarm_clock,
	D => alarm,
	R => not(alarm_reset),
	Q => DY_out
);

DZ:d_flip_flop port map(
	clock => alarm_clock,
	D => DZ_in,
	R => not(alarm_reset),
	Q => DZ_out
);

DA:d_flip_flop port map(
	clock => alarm_clock,
	D => DA_in,
	R => not(alarm_reset),
	Q => DA_out
);

DB:d_flip_flop port map(
	clock => alarm_clock,
	D => DB_in,
	R => not(alarm_reset),
	Q => DB_out
);


-- outputs
alarm_out <= DZ_out;
b0_out <= DA_out nor DB_out;
b1_out <= not(DA_out) nor DB_out;
b2_out <= DA_out nor not(DB_out);

end Behavioral;

