library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.Arr_Mat.all;

entity adder_tree is
	Port(
		-- a matrix made of outputs of HMMs 
		in_1 : in int_mat := (
			(1,1,1,1,1,2,2,others => 0),
			(others => 0),
			(others => 0),
			(others => 0),
			(others => 0),
			(others => 0),
			(others => 0),
			others => (others => 0)
		);
		out_1 : out integer
	);
end adder_tree;

architecture Behavioral of adder_tree is
	component adder_level is
		-- should use number-1 in toper modules
		Generic(N : integer);
		Port(
			in_1 : in int_arr ;--:= (0,1,2,3,4,others => 0);
			out_1: out int_arr
		);
	end component adder_level;
	signal t1,t2,t3,t4,t5,t6,t7 : int_arr;
begin


	gen0 : for i in 0 to 7 generate
		inner0:if i = 0 generate 
			t1(0 to 6) <= in_1(0)(0 to 6);
			t1(7 to 13) <= in_1(1)(0 to 6);
			t1(14 to 20) <= in_1(2)(0 to 6);
			t1(21 to 27) <= in_1(3)(0 to 6);
			t1(28 to 34) <= in_1(4)(0 to 6);
			t1(35 to 41) <= in_1(5)(0 to 6);
			t1(42 to 48) <= in_1(6)(0 to 6);
		end generate inner0;
		
		inner1:if i = 1 generate
			al_49_25 : adder_level generic map (N => 48) port Map(
				out_1 => t2,
				in_1 => t1
			);
		end generate inner1;
		inner2:if i = 2 generate
			al_25_13 : adder_level Generic Map(N => 24) Port Map(
				out_1 => t3,
				in_1 => t2
			);
		end generate inner2;
		
		inner3:if i = 3 generate
			al_13_7 : adder_level Generic Map(N => 12) Port Map(
				out_1 => t4,
				in_1 => t3
			);
		end generate inner3;
		
		inner4:if i = 4 generate
			al_7_4 : adder_level Generic Map(N => 6) Port Map(
				out_1 => t5,
				in_1 => t4
			);
		end generate inner4;

		inner5:if i = 5 generate
			al_4_2 : adder_level Generic Map(N => 3) Port Map(
				out_1 => t6,
				in_1 => t5
			);
		end generate inner5;

		inner6:if i = 6 generate
			al_2_1 : adder_level Generic Map(N => 1) Port Map(
				out_1 => t7,
				in_1 => t6
			);
		end generate inner6;

		inner7:if i = 7 generate
			out_1 <= t7(0);
		end generate inner7;

	end generate gen0;
end Behavioral;

