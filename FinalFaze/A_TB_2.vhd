LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use STD.textio.all;

ENTITY A_TB_2 IS
END A_TB_2;
 
ARCHITECTURE behavior OF A_TB_2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
 
    COMPONENT A
    PORT(
         start : IN  std_logic;
         Data : IN  std_logic_vector(7 downto 0);
         Count : IN  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         End1 : OUT  std_logic;
         Sum : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal start : std_logic := '0';
   signal Data : std_logic_vector(7 downto 0) := (others => '0');
   signal Count : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal End1 : std_logic;
   signal Sum : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: A PORT MAP (
          start => start,
          Data => Data,
          Count => Count,
          clk => clk,
          End1 => End1,
          Sum => Sum
        );

   -- Clock process definitions
   clk_process :process
		variable t1 : integer := 0;
		file ftb : text open read is "input.txt";
		file myl : line;
		variable cnter: std_logic_vector(0 to 7) := (others => 0);
	begin
		if cnter = 0 then
				readline(ftb,myl);
				read(myl, Count); 
		end if;
		if cnter = Count then
				readline(ftb,myl);
				read(myl, Data); 
		end if;
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
		t1 := t1 + 1;
   end process;

END;
