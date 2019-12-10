library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.Int_Array.all;

entity Non_Pipe_2to1 is
	
	Generic(
		N : integer := 3
	);
	Port(
		in_1 : in int_mat3;
		in_2 : in int_mat3;
		out_1: out integer
	);
end Non_Pipe_2to1;

architecture Behavioral of Non_Pipe_2to1 is

	component HMM is
		generic(N : Integer := 2);
		Port(
			hmm_in1 : in int_arr3;
			hmm_in2 : in int_arr3;
			hmm_out : out int_arr3
		);
	end component HMM;
	
	component Adder_Tree_2_to_1 is
	Port(
		in_1 : integer;
		in_2 : integer;
		out_1 : integer
	);
	end component;
	signal t1,t2,t3 : int_arr3;
begin


end Behavioral;

