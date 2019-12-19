LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
library work;
use work.arr_mat.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY PAM5_TB IS
END PAM5_TB;
 
ARCHITECTURE behavior OF PAM5_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PAM5
    PORT(
         in_1 : IN  int_arr;
         in_2 : IN  int_arr;
         clk : IN  Bit;
         out_1 : OUT  Integer
        );
    END COMPONENT;
    

   --Inputs
   signal in_1 : int_arr := (1,1,1,others => 0);
   signal in_2 : int_arr := (1,1,1,others => 0);
   signal clk : Bit := '0';

 	--Outputs
   signal out_1 : integer;

   -- Clock period definitions
   constant clk_period : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PAM5 PORT MAP (
          in_1 => in_1,
          in_2 => in_2,
          clk => clk,
          out_1 => out_1
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
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
