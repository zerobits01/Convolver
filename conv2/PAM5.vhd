library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.arr_mat.all;


entity PAM5 is
	Generic(N : integer := 4);
	Port(
		in_1 : in int_arr;
		in_2 : in int_arr;
		clk  : in Bit;
		out_1: out integer
	);
end PAM5;

architecture Behavioral of PAM5 is
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
	signal temp : integer;
begin
	process(clk)
		variable counter : integer := 0;
	begin 
		if (clk'event and clk = '1') then
			if (counter < 5) then
				if counter = 0 then
					add_res(counter) <= reg_res(2*counter) + 0;
				else
					pro_res(counter) <= in_1(counter) * in_2(counter);
					add_res(counter) <= reg_res(2*counter) + reg_res(2*counter-1);
				end if;
			end if;
			temp <= counter;
			counter := counter + 1;
		end if;
 	end process;
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
	
	out_1 <= add_res(5);

end Behavioral;

--		gen1 : if i = 0 generate
--			pa0 : DFF port map (
--				d => reg_res(1),
--				clk => clk,
--				q => reg_res(0)
--			);			
--		end generate gen1;