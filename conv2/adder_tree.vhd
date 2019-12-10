library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.Arr_Mat.all;

entity adder_tree5 is
	Port(
		-- a matrix made of outputs of HMMs 
		in_1 : in int_mat := (
			(0,0,0,0,0,others => 0),
			(0,0,0,0,0,others => 0),
			(0,0,0,0,0,others => 0),
			(0,0,0,0,0,others => 0),
			(1,1,1,1,1,others => 0),
			others => (others => 0)
		);
		out_1 : out integer
	);
end adder_tree5;

architecture Behavioral5 of adder_tree5 is
	component adder_levels is
		-- should use number-1 in toper modules
		Generic(N : integer);
		Port(
			in_1 : in int_arr ;--:= (0,1,2,3,4,others => 0);
			out_1: out int_arr
		);
	end component adder_levels;
	signal t1,t2,t3,t4,t5,t6 : int_arr;
	signal counter : integer := 0;
begin
	gen : for i in 0 to 4 generate
		inner_gen : for j in 0 to 4 generate
			t1(counter) <= in_1(i)(j);
			counter <= counter+1;
		end generate;
	end generate;
	al_25_13 : adder_levels Generic Map(N => 24) Port Map(
		out_1 => t2,
		in_1 => t1
	);
	
	al_13_7 : adder_levels Generic Map(N => 12) Port Map(
		out_1 => t3,
		in_1 => t2
	);
	
	al_7_4 : adder_levels Generic Map(N => 6) Port Map(
		out_1 => t4,
		in_1 => t3
	);
	
	al_4_2 : adder_levels Generic Map(N => 3) Port Map(
		out_1 => t5,
		in_1 => t4
	);

	al_2_1 : adder_levels Generic Map(N => 1) Port Map(
		out_1 => t6,
		in_1 => t5
	);
	out_1 <= t6(0);
end Behavioral5;

