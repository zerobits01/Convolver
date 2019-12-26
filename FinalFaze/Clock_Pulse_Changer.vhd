library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Clock_Pulse_Changer is

	Generic(
			first_step : integer := 30;
			second_step : integer := 40;
			third_step : integer := 50;
			fourth_step : integer := 20
--			For Part B we can use the below steps instead uppers
--			first_step : integer := 15;
--			second_step : integer := 20;
--			third_step : integer := 25;
--			fourth_step : integer := 10
	);
	Port(
		clk : In Bit;
		out_clk : out Bit
	);
end Clock_Pulse_Changer;

architecture Behavioral of Clock_Pulse_Changer is
	type state is (first, second, third, fourth);
	signal cur_state : state := first;
	
	-- the clk is 100 MHz, 10ns
	-- a counter and checking an if the counter is complete then make it zero and change the state
	-- first state : 30
	-- second state: 40
	-- third state : 50
	-- fourth state: 20

begin
	process(clk)
		variable counter : integer := 0;
	begin
		if (clk'event) and (clk = '1') then
			case cur_state is
				when first =>
					if (counter = first_step) then
						counter := 0;
						cur_state <= second;
						out_clk <= '1';
					else
						counter := counter + 1;
					end if;
				when second =>
					if (counter = second_step) then
						counter := 0;
						cur_state <= third;
						out_clk <= '0';
					else
						counter := counter + 1;
					end if;
				when third =>
					if (counter = third_step) then
						counter := 0;
						cur_state <= fourth;
						out_clk <= '1';
					else
						counter := counter + 1;
					end if;
				when fourth =>
					if (counter = fourth_step) then
						counter := 0;
						cur_state <= first;
						out_clk <= '0';
					else
						counter := counter + 1;
					end if;
			end case;
		end if;
	end process;

end Behavioral;

