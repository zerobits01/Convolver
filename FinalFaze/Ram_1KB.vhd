library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;

entity Ram_1KB is
	Generic(
		N : integer := 1024;
		Block_Size : integer := 8
	);
	Port(
		to_do : integer;
		data_to_write : in std_logic_vector(0 to Block_Size-1);
		addr : in integer; -- ten bits for 1024 block of ram
		write_ena: in std_logic;
		clk : in std_logic; -- for checking the states
		read_out : out std_logic_vector(0 to Block_Size-1)
	);
end Ram_1KB;

architecture Behavioral of Ram_1KB is
	type ram is array(0 to N-1) of std_logic_vector(0 to Block_Size-1);
	type state is (idle, read_state, write_state);
	-- 0 idle 				: nothing to do
	-- 1 read_state     : reads the addr block and put in read_out
	-- 2 write_state    : if write enable is on writes the data_to_write on addr block
	signal cur_state : state := idle;
	signal nxt_state : state;
	signal my_ram : ram := (others => (others => '0')); -- because after reset ram will be cleared
begin
	process(clk,to_do)
	begin
		if (clk'event) and (clk = '1') then
			cur_state <= nxt_state;
		end if;
	end process;
	
	process(cur_state, to_do)
		variable t1 : std_logic_vector(0 to 7);
		variable t2 : integer;
		variable t3 : std_logic_vector(0 to 23);
	begin
		case cur_state is
			when idle => 
				case to_do is
					when 0 =>
						nxt_state <= idle;
					when 1 =>
						nxt_state <= read_state;
					when 2 =>
						if write_ena = '1' then
							nxt_state <= write_state;
						end if;
					when others => NULL;
				end case;
			when read_state => 
					read_out <= my_ram(addr);
					nxt_state <= idle;
			when write_state => 
					my_ram(addr) <= data_to_write;
					nxt_state <= idle;
			when others => t2 := 0;--cur_state <= idle;
		end case;
	end process;
end Behavioral;

