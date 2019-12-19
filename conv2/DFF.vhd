library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFF is
	Port(
		d : in integer;
		clk : in Bit;
		q : out integer
	);
end DFF;

architecture Behavioral of DFF is

begin
	process(clk)
	begin
		if(clk'event and clk = '1') 
		then
			q <= d;
		end if;
	end process;

end Behavioral;

