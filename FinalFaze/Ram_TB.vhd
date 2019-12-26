LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY Ram_TB IS
END Ram_TB;
 
ARCHITECTURE behavior OF Ram_TB IS 
 
 
    COMPONENT Ram_1KB
    PORT(
         data_to_write : IN  std_logic_vector(0 to 7);
         addr : IN  integer;
         write_ena : IN  std_logic;
         to_do : IN  integer;
         clk : IN  std_logic;
         read_out : OUT  std_logic_vector(0 to 7)
        );
    END COMPONENT;
    

   --Inputs
   signal data_to_write : std_logic_vector(0 to 7) := (others => '0');
   signal addr : integer ;
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
			when 0 => 
				if 4 < 5 then
				   data_to_write <= (others => '1');
					addr <= 0;
					write_ena <= '1';
					to_do <= 2;
				end if;
			when 1 => 
				if 4 < 5 then
				   addr <= 0;
					to_do <= 1;
				end if;
			when 2 => 
				if 4 < 5 then
				   to_do <= 3;
				end if;
			when 3 => 
				if 4 < 5 then
					data_to_write <= (others => '1');
					addr <= 1;
					write_ena <= '1';
					to_do <= 2;
				end if;
			when 4 => 
				if 4 < 5 then
				   to_do <= 4;
				end if;
				
			when others => test := 0;
		end case;
		test := test + 1;

		clk <= '1';

		wait for clk_period/2;
   end process;

END;
