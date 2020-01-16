library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity A is
	port(
		start : in std_logic;
		Data, Count : in std_logic_vector(7 downto 0);
		clk: in std_logic;
		End1: out std_logic;
		Sum : out std_logic_vector(15 downto 0):=(others => '0')
	);
end A;

architecture Behavioral of A is
	type state is (idle, getData, endSum);
	signal pr_state: state := idle;
	signal nx_state : state;
--	variable counter :  std_logic_vector(7 downto 0):= (others => '0');

--	signal count1: std_logic_vector(7 downto 0);
begin
	process(clk)
		begin
			if(rising_edge(clk)) then
				pr_state <= nx_state;
			end if;
	end process;
	 
	process(pr_state, Data, count)
		variable sum1 : std_logic_vector(15 downto 0):= (others => '0');
		variable counter : std_logic_vector(7 downto 0):= "00000001";

		begin
--			assert false
--			report "test"
--			severity NOTE;
			case pr_state is
				when idle =>					
					Sum <= (others => '0');
					End1 <= '0';
					if(start = '1') then
						assert false
						report "idle"
						severity NOTE;
	--					count1 <= Count;
						nx_state <= getData;
					end if;
				when  getData =>
					if(count = counter) then
						assert false
						report "getDAta" 
						severity NOTE;

						sum1 := sum1 + data;
						nx_state <= endSum;
					else
						sum1 := sum1 + Data;
					end if;
					counter := counter + 1; --- may using signal
				when endSum =>
					assert false
						report "endSun" 
						severity NOTE;
					End1 <= '1';					
					Sum <= sum1;
					nx_state <= idle;
				when others => null;
			end case;
	end process;

end Behavioral;

