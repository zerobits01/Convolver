library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.arr_mat.all;

entity adder_levels is
	-- should use number-1 in toper modules
	Generic(N : integer);
	Port(
		in_1 : in int_arr ;--:= (0,1,2,3,4,others => 0);
		out_1: out int_arr
	);
	type intarr is array(0 to (N+1)/2) of integer;
end adder_levels;
	
architecture Behavioral of adder_levels is
	component adder_2_to_1 is
		Port(
			in_1 : in integer;
			in_2 : in integer;
			out_1: out integer
		);
	end component adder_2_to_1;
 
begin	
	gen : for i in 0 to N generate
		inner_if : if (i mod 2 = 1) generate
			l1 : adder_2_to_1 Port Map(in_1 => in_1(i), in_2 => in_1(i-1),out_1 => out_1(((i-1)/2)));
--			out_1(((i-1)/2)) <= in_1(i) + in_1(i-1);
		end generate;
	end generate;
	out_1((N+1)/2) <= in_1(N) when N mod 2 = 0;
end Behavioral;

