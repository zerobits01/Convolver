library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work;
use work.Int_Array.all;

entity Adder_Level3 is
	-- point in upper levels last index should be 0;
	Port(
		in_1 : in int_arr10;
		out_1 : out integer
	);
end Adder_Level;

architecture Behavioral of Adder_Level3 is

	component Adder_Tree_2_to_1 is
		Port(
			in_1 : integer;
			in_2 : integer;
			out_1 : integer
		);
	end component;
	variable temp : ;
begin
	
	process(in_1)
	begin
		loop1 : for i in 0 to 10 loop
			if i mod 2 = 1 then
				lbl : Adder_Tree_2_to_1 Port Map(in_1(i) + in_1(i+1),temp(i))
			end if;
		end loop;
	end process;

end Behavioral;

