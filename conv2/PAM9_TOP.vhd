library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.arr_mat.all;

entity PAM9_TOP is
	Port(
			in_1 : in int_mat;
			in_2 : in int_mat;
			clk  : in Bit; 
			out_1: out integer
	);
end PAM9_TOP;

architecture Behavioral of PAM9_TOP is
	component PAM9 is
		Generic(N : integer := 8);
		Port(
			in_1 : in int_arr;
			in_2 : in int_arr;
			clk  : in Bit;
			out_1: out integer;
			temp : OUT integer
		);
	end component PAM9;
	signal temp : int_arr := (others => 0);
begin
	gen : for i in 0 to 9 generate
		pam : PAM9 port map(
			in_1 => in_1(i),
			in_2 => in_2(i),
			clk => clk,
			out_1 => temp(i)
		); 
		gen1 : if i = 9 generate
			out_1 <= temp(0) + temp(1) + temp(2) + temp(3) + temp(4) + temp(5) + temp(6) + temp(7) + temp(8);
		end generate gen1;
	end generate;
end Behavioral;

