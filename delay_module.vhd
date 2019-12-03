----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:09:24 12/03/2019 
-- Design Name: 
-- Module Name:    delay_module - Behavioral 
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

entity delay_module is
    Port ( d_clock : in  STD_LOGIC;
           d_enable : in  STD_LOGIC;
           d_out : out  STD_LOGIC);
end delay_module;

architecture Behavioral of delay_module is

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

component d_flip_flop is 
	Port(
			clock : in  STD_LOGIC;
           D : in  STD_LOGIC;
           R : in  STD_LOGIC;
           Q : out  STD_LOGIC
	);
end component;

-- time for the delay 50M = 1 second
constant max_count : natural := 250000000; -- 5 seconds by default
signal q_A, q_B, mux_B_out, internal_delay : STD_LOGIC;

begin

d_out <= internal_delay;

mux_B:mux_4x1 port map(
	m0 => '0',
	m1 => not(internal_delay),
	m2 => not(d_enable),
	m3 => '0',
	s0 => q_B,
	s1 => q_A,
	mux_out => mux_B_out
);

delay_DA:d_flip_flop port map(
	clock => d_clock,
	D => d_enable,
	R => '1',
	Q => q_A
);

delay_DB:d_flip_flop port map(
	clock => d_clock,
	D => mux_B_out,
	R => '1',
	Q => q_B
);

counter : process(d_clock)
  variable count : integer := 0;
	begin
		if rising_edge(d_clock) then
			if(q_A = '0' and q_B = '0') then
				count:=0;
			end if;
			
			if(q_A = '0' and q_B = '1') then
				if count > max_count - 1 then
					 internal_delay <= '1';
					 count:=0;
				else 
					count := count + 1;
					internal_delay <= '0';
				end if;
			end if;
		end if;
end process counter;

end Behavioral;
