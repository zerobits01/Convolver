LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DFF_TB IS
END DFF_TB;
 
ARCHITECTURE behavior OF DFF_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DFF
    PORT(
         d : IN  integer;
         clk : IN  Bit;
         q : OUT  integer
        );
    END COMPONENT;
    

   --Inputs
   signal d : integer := 1;
   signal clk : Bit := '0';

 	--Outputs
   signal q : integer;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DFF PORT MAP (
          d => d,
          clk => clk,
          q => q
        );

   -- Clock process definitions
   clk_process :process
		variable t : integer;
   begin
		t := t + 1;
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		d <= t mod 4;
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
