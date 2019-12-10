library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_2_to_1 is
	Port(
		in_1 : in integer;
		in_2 : in integer;
		out_1: out integer
	);
end adder_2_to_1;

architecture Behavioral of adder_2_to_1 is
begin
	out_1 <= in_1 + in_2;
end Behavioral;

