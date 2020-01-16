
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY C_TB IS
END C_TB;
 
ARCHITECTURE behavior OF C_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
 
    COMPONENT C
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
   uut: C PORT MAP (
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
	begin

		clk <= '0';
		wait for clk_period/2;
		case t1 is
			when 0 =>
				start <= '1';
				
			when 1 =>
				start <= '0';
				Count <= "00000011";
			when 2 =>
				Data <= "00000100";
			when 3 =>
				Data <= "00000101";
			when 4 => Data <= "00000111"; 
			when others => NULL;
		end case;
		clk <= '1';
		wait for clk_period/2;
		t1 := t1 + 1;
   end process;
 

--   -- Stimulus process
--   stim_proc: process
--   begin		
--      -- hold reset state for 100 ns.
--      wait for 100 ns;	
--
--      wait for clk_period*10;
--
--      -- insert stimulus here 
--
--      wait;
--   end process;

END;
