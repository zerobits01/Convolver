LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY Ram_TB IS
END Ram_TB;
 
ARCHITECTURE behavior OF Ram_TB IS 
 
 
    COMPONENT Ram_1KB
    PORT(
         data_to_write : IN  std_logic_vector(0 to 7);
         addr : IN  integer range 0 to 1023;
         write_ena : IN  std_logic;
         to_do : IN  positive;
         clk : IN  std_logic;
         read_out : OUT  std_logic_vector(0 to 7)
        );
    END COMPONENT;
    

   --Inputs
   signal data_to_write : std_logic_vector(0 to 7) := (others => '0');
   signal addr : integer range 0 to 1023 ;
   signal write_ena : std_logic := '0';
   signal to_do : integer := 0;
   signal clk : std_logic := '0';

 	--Outputs
   signal read_out : std_logic_vector(0 to 7);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Ram_1KB PORT MAP (
          data_to_write => data_to_write,
          addr => addr,
          write_ena => write_ena,
          to_do => to_do,
          clk => clk,
          read_out => read_out
        );

   -- Clock process definitions
   clk_process :process
		variable test : integer := 0;
	begin
		clk <= '0';
		wait for clk_period/2;
		case test is
--			when 1 => 
--				addr <= 0;
--				to_do <= 1;
--			when 2 => 
--				addr <= 1;
--				to_do <= 1;
--			when 3 => 
--				addr <= 2;
--				to_do <= 1;
--			when 4 => 
--				addr <= 2;
--				data_to_write <= "11111111";
--				write_ena <= '1';
--				to_do <= 2;
--			when 5 => 
--				addr <= 2;
--				to_do <= 1;					
			when 6 => 
				 to_do <= 4; 
			
			when 7001 => 
				addr <= 0;
				to_do <= 1;		

			when others => Null; 
		end case;
		test := test + 1;
		clk <= '1';
		wait for clk_period/2;
	end process;

END;
