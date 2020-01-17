LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.math_real.all;


ENTITY A_TB_1 IS
END A_TB_1;
 
ARCHITECTURE behavior OF A_TB_1 IS 

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
		variable rand : real;
		variable int_rand : integer;
		variable seed1, seed2 : positive;
		variable cnter : integer := 0;
	begin
		UNIFORM(seed1,seed2,rand);
		int_rand := integer(trunc(rand * 256.0));
		if cnter = 0 then 
			start <= '1';
			Count <= conv_std_logic_vector(int_rand, 8);
		else
			start <= '0';
		end if;
		clk <= '0';
		wait for clk_period/2;
		for i in 0 to int_rand loop
			Data <= conv_std_logic_vector(int_rand, 8);
		end loop;
		clk <= '1';
		wait for clk_period/2;
		t1 := t1 + 1;
   end process;

END;
