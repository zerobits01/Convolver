library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.arr_mat.all;

entity non_pipeline_convolver5 is
	port(
		input_mat : in int_mat := (
				(1,1,1,1,1,others => 0),
				(others => 0),
				(others => 0),
				(others => 0),
				(others => 0),
				others => (others => 0)
			);
		input_img : in int_mat := (
				(2,1,1,1,1,others => 0),
				(others => 0),
				(others => 0),
				(others => 0),
				(others => 0),
				others => (others => 0)
			);
		out_1 : out integer
	);
end non_pipeline_convolver5;

architecture Behavioral of non_pipeline_convolver5 is
	component adder_tree5 is
		Port(
			in_1 : in int_mat;  -- := (
--				(1,1,1,1,1,others => 0),
--				(others => 0),
--				(others => 0),
--				(others => 0),
--				(others => 0),
--				others => (others => 0)
--			);
			out_1 : out integer
		);
	end component adder_tree5;
	
	
	component HMM5 is
		generic(N : Integer := 4);
		Port(
			hmm_in1 : in int_arr;
			hmm_in2 : in int_arr;
			hmm_out : out int_arr
		);
	end component HMM5; 
	signal temp : int_mat := (
				(others => 0),
				(others => 0),
				(others => 0),
				(others => 0),
				(others => 0),
				others => (others => 0)
			);
begin
	
	gen : for i in 0 to 4 generate
		h : HMM5 generic map (N => 4) port map(
			hmm_in1 => input_mat(i),
			hmm_in2 => input_img(i),
			hmm_out => temp(i)
		);
	end generate gen;

	ad : adder_tree5 port map (
		in_1 => temp,
		out_1 => out_1
	);
end Behavioral;

