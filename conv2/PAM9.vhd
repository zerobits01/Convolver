library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.arr_mat.all;


entity PAM9 is
	Generic(N : integer := 8);
	Port(
		in_1 : in int_arr;
		in_2 : in int_arr;
		clk  : in Bit;
		out_1: out integer;
		temp : OUT integer

	);
end PAM9;

architecture Behavioral of PAM9 is
	component DFF is
			Port(
				d : in integer;
				clk : in Bit;
				q : out integer
			);
	end component DFF;
	signal pro_res : int_arr := (others => 0);
	signal reg_res : int_arr := (others => 0);
	signal add_res : int_arr := (others => 0);
begin
	gen : for i in 0 to 2*N+1 generate
		gen2 : if (i mod 2 = 0) generate
			pa0 : DFF port map (
				d => pro_res(i/2),
				clk => clk,
				q => reg_res(i)
			);			
		end generate gen2;
		
		gen3 : if (i mod 2 = 1) generate
			pa0 : DFF port map (
				d => add_res(i/2),
				clk => clk,
				q => reg_res(i)
			);			
		end generate gen3;
		
	end generate gen;
 
	process(clk)
		variable counter : integer := 0;
	begin 
		if (clk'event and clk = '1') then
			if (counter < 9) then -- N + 1
				pro_res(counter) <= in_1(counter) * in_2(counter);
				
				if counter = 0 then
					add_res(0) <= reg_res(0);
				else
					add_res(counter) <= reg_res(2*counter) + reg_res(2*counter-1);
				end if;
				
				temp <= counter;
				counter := counter + 1;				
			else 
				counter := 0;
			end if;
		end if;
		out_1 <= reg_res(17); -- 2*N - 1
 	end process;


end Behavioral; 

