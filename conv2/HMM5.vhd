library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HMM5 is
	generic(N : Integer := 4);
	Port(
		hmm_in1 : in int_arr;
		hmm_in2 : in int_arr;
		hmm_out : out int_arr
	);
end HMM5; 

architecture Behavioral of HMM5 is

begin
	gen : for i in 0 to N generate
		hmm_out(i) <= hmm_in1(i) * hmm_in2(i);
	end generate;
end Behavioral;