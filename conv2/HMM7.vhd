library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.arr_mat.all;


entity HMM7 is
	generic(N : Integer := 6);
		Port(
			hmm_in1 : in int_arr;
			hmm_in2 : in int_arr;
			hmm_out : out int_arr
		);
	end HMM7;

architecture Behavioral of HMM7 is

begin
	
	gen : for i in 0 to N generate
		hmm_out(i) <= hmm_in1(i) * hmm_in2(i);
	end generate;

end Behavioral;

