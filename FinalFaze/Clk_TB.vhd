LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY Clk_TB IS
END Clk_TB;
 
ARCHITECTURE behavior OF Clk_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Clock_Pulse_Changer
    PORT(
         clk : IN  Bit;
         out_clk : OUT  Bit
        );
    END COMPONENT;
    

   --Inputs
   signal clk : Bit := '0';

 	--Outputs
   signal out_clk : Bit;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant out_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Clock_Pulse_Changer PORT MAP (
          clk => clk,
          out_clk => out_clk
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

END;
