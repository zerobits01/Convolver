library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.Arr_Mat.all;

entity adder_tree9 is
	Port(
		-- a matrix made of outputs of HMMs 
		in_1 : in int_mat := (
			(2,1,1,1,1,1,1,1,1,others => 0),
			(others => 0),
			(others => 0),
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
end adder_tree9;

architecture Behavioral9 of adder_tree9 is
	component adder_levels is
		-- should use number-1 in toper modules
		Generic(N : integer);
		Port(
			in_1 : in int_arr ;--:= (0,1,2,3,4,others => 0);
			out_1: out int_arr
		);
	end component adder_levels;
	signal t1,t2,t3,t4,t5,t6,t7,t8 : int_arr;
--	signal counter : integer := 0;
begin
	gen0 : for i in 0 to 8 generate
		inner0:if i = 0 generate 
			t1(0 to 8)   <= in_1(0)(0 to 8);
			t1(9 to 17)  <= in_1(1)(0 to 8);
			t1(18 to 26) <= in_1(2)(0 to 8);
			t1(27 to 35) <= in_1(3)(0 to 8);
			t1(36 to 44) <= in_1(4)(0 to 8);
			t1(45 to 53) <= in_1(5)(0 to 8);
			t1(54 to 62) <= in_1(6)(0 to 8);
			t1(63 to 71) <= in_1(7)(0 to 8);
			t1(72 to 80) <= in_1(8)(0 to 8);
			
		end generate inner0;
		
		inner1:if i = 1 generate
			al_81_41 : adder_levels Generic Map(N => 80) Port Map(
				out_1 => t2,
				in_1 => t1
			);
		end generate inner1;
		
		
		
		inner2:if i = 2 generate
			al_41_21 : adder_levels Generic Map(N => 40) Port Map(
				out_1 => t3,
				in_1 => t2
			);
		end generate inner2;
		
		
		
		inner3:if i = 3 generate
			al_21_11: adder_levels Generic Map(N => 20) Port Map(
				out_1 => t4,
				in_1 => t3
			);
		end generate inner3;
		
		
		
		
		inner4:if i = 4 generate
			al_11_6: adder_levels Generic Map(N => 10) Port Map(
				out_1 => t5,
				in_1 => t4
			);
		end generate inner4;
		
		
		
		
		inner5:if i = 5 generate
		al_6_3: adder_levels Generic Map(N => 5) Port Map(
				out_1 => t6,
				in_1 => t5
			);
		end generate inner5;




		inner6:if i = 6 generate
			al_3_2 : adder_levels Generic Map(N => 2) Port Map(
				out_1 => t7,
				in_1 => t6
			);
		end generate inner6;
		

		
		inner7:if i = 7 generate
		al_2_1 : adder_levels Generic Map(N => 1) Port Map(
				out_1 => t8,
				in_1 => t7
			);
		end generate inner7;





		inner8:if i = 8 generate
			out_1 <= t8(0);
		end generate inner8;

	end generate gen0;
end Behavioral9;

--	process(in_1)
--	begin
--		gen : for i in 0 to 4 loop
--			inner_gen : for j in 0 to 4 loop
--				t1(counter) <= in_1(i)(j);
--				counter <= counter+1;
--			end loop;
--		end loop;
--	end process;
--	
--	process(t2)
--	begin
--		al_25_13 : adder_levels Generic Map(N => 24) Port Map(
--			out_1 => t2,
--			in_1 => t1
--		);
--	end process;
--	
--	process(t2)
--	begin
--		al_13_7 : adder_levels Generic Map(N => 12) Port Map(
--			out_1 => t3,
--			in_1 => t2
--		);
--	end process;
--
--	
--	process(t3)
--	begin
--		al_7_4 : adder_levels Generic Map(N => 6) Port Map(
--			out_1 => t4,
--			in_1 => t3
--		);
--	end process;
--	
--	process
--	begin
--		al_4_2 : adder_levels Generic Map(N => 3) Port Map(
--			out_1 => t5,
--			in_1 => t4
--		);
--	end process;
--
--	process(t5)
--	begin
--		al_2_1 : adder_levels Generic Map(N => 1) Port Map(
--			out_1 => t6,
--			in_1 => t5
--		);
--	end process;
--
--	process(t5)
--	begin
--		out_1 <= t6(0);
--	end process;
