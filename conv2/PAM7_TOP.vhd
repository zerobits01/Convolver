library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.arr_mat.all;

entity PAM7_TOP is
	Port(
			in_1 : in int_mat;
			in_2 : in int_mat;
			clk  : in Bit; 
			out_1: out integer
	);
end PAM7_TOP;

architecture Behavioral of PAM7_TOP is
	component PAM7 is
		Generic(N : integer := 6);
		Port(
			in_1 : in int_arr;
			in_2 : in int_arr;
			clk  : in Bit;
			out_1: out integer;
			temp : OUT integer
		);
	end component PAM7;
	signal temp : int_arr := (others => 0);
begin
	gen : for i in 0 to 7 generate
		pam : PAM7 port map(
			in_1 => in_1(i),
			in_2 => in_2(i),
			clk => clk,
			out_1 => temp(i)
		); 
		gen1 : if i = 7 generate
			out_1 <= temp(0) + temp(1) + temp(2) + temp(3) + temp(4) + temp(5) + temp(6);
		end generate gen1;
	end generate;
end Behavioral;

