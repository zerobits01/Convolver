----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:44:21 12/09/2019 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_Arith.all;

library work;
use work.Int_Array.all;
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


--architecture Behavioral of Non_Pipeline_Convolver is
--
--	component HMM is
--		generic(N : Integer := 2);
--		Port(
--			hmm_in1 : in int_arr3;
--			hmm_in2 : in int_arr3;
--			hmm_out : out int_arr3
--		);entity Non_Pipeline_Convolver3 is 
		Port(
			input_core : in int_mat3:= (
				(1,2,3),
				(1,2,3),
				(0,0,0)
			);
			input_imag : in int_mat3 := (
				(1,2,3),
				(1,2,3),
				(0,0,0)
			);
			output : inout integer
		);
 
end Non_Pipeline_Convolver3;

--	end component HMM;
--
--	component Adder_Tree is
--		generic(N : integer := 2);
--		Port(
--			in1 : in int_arr3;
--			in2 : in int_arr3;
--			in3 : in int_arr3;
--			conv_res : out integer
--		);
-- 
--	end component Adder_Tree;
--	
--	component Adder_Tree_2_to_1 is
--	Port(
--		in_1 : integer;
--		in_2 : integer;
--		out_1 : integer
--	);
--	end component;
--	signal t1,t2,t3 : int_arr3;
--	
----	signal t4 : unsigned(0 to 8);
--begin
--	hmm1 : HMM port map(hmm_in1 => input_core(0),hmm_in2 => input_imag(0),hmm_out => t1);
--	hmm2 : HMM port map(hmm_in1 => input_core(1),hmm_in2 => input_imag(1),hmm_out => t2);
--	hmm3 : HMM port map(hmm_in1 => input_core(2),hmm_in2 => input_imag(2),hmm_out => t3);
--	addt : Adder_Tree port map(t1,t2,t3,output);
----	t4 <= to_unsigned(output,8);
--end Behavioral;

architecture Behavioral of Non_Pipeline_Convolver is

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
	
--	signal t4 : unsigned(0 to 8);
begin
	hmm1 : HMM port map(hmm_in1 => input_core(0),hmm_in2 => input_imag(0),hmm_out => t1);
	hmm2 : HMM port map(hmm_in1 => input_core(1),hmm_in2 => input_imag(1),hmm_out => t2);
	hmm3 : HMM port map(hmm_in1 => input_core(2),hmm_in2 => input_imag(2),hmm_out => t3);
	addt : Adder_Tree port map(t1,t2,t3,output);
--	t4 <= to_unsigned(output,8);
end Behavioral;

