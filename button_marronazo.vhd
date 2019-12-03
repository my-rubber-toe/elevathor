----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:09:10 12/02/2019 
-- Design Name: 
-- Module Name:    button_marronazo - Behavioral 
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

entity button_marronazo is
    Port ( alarm_in : in  STD_LOGIC;
           b0_alarm_in : in  STD_LOGIC;
			  b1_alarm_in : in  STD_LOGIC;
			  b2_alarm_in : in  STD_LOGIC;
			  b0_in : in  STD_LOGIC;
			  b1_in : in  STD_LOGIC;
			  b2_in : in  STD_LOGIC;
           b0_out : out  STD_LOGIC;
			  b1_out : out  STD_LOGIC;
			  b2_out : out  STD_LOGIC
			  
			  );
end button_marronazo;

architecture Behavioral of button_marronazo is

begin

b0_out <= (b0_alarm_in and b0_in)or (b0_in and not(alarm_in));
b1_out <= (not(alarm_in) and b1_in) or (alarm_in and b1_alarm_in);
b2_out <= (not(alarm_in) and b2_in) or (alarm_in and b2_alarm_in);


end Behavioral;

