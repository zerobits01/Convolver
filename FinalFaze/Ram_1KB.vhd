library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;

entity Ram_1KB is
	Generic(
		N : integer := 1024;
		Block_Size : integer := 8
	);
	Port(
		data_to_write : in std_logic_vector(0 to Block_Size-1);
		addr : in integer; -- ten bits for 1024 block of ram
		write_ena: in std_logic;
		to_do : in integer; -- checks what to do states from left to right enumerated
		clk : in std_logic; -- for checking the states
		read_out : out std_logic_vector(0 to Block_Size-1)
	);
end Ram_1KB;

architecture Behavioral of Ram_1KB is
	type ram is array(0 to N-1) of std_logic_vector(0 to Block_Size-1);
	type state is (idle, read_state, write_state, swap_state, sum_state, check_zb_replication);
	-- idle 				: nothing to do
	-- read_state     : reads the addr block and put in read_out
	-- write_state    : if write enable is on writes the data_to_write on addr block
	-- swap_state     : swap all odds and evens blocks
	-- sum_state      : sums all the blocks and save it completely it may need more than one byte
	-- zb_replication : checks the count of replication of zero block of ram
	signal cur_state : state := idle;
	signal my_ram : ram := (others => (others => '0')); -- because after reset ram will be cleared
begin
	process(clk,to_do)
	begin
		if (clk'event) and (clk = '1') then
			case to_do is
				when 0 =>
					cur_state <= idle;
				when 1 =>
					cur_state <= read_state;
				when 2 =>
					if write_ena = '1' then
						cur_state <= write_state;
					end if;
				when 3 =>
					cur_state <= swap_state;
				when 4 =>
					cur_state <= sum_state;
				when 5 =>
					cur_state <= check_zb_replication;
				when others => cur_state <= idle;
			end case;
		end if;
	end process;
	
	process(cur_state)
		variable t1 : std_logic_vector(0 to 7);
		variable t2 : integer;
		variable t3 : std_logic_vector(0 to 23);
	begin
		case cur_state is
			when read_state => 
				if 5 > 4 then
					read_out <= my_ram(addr);
--					cur_state <= idle;
				end if;
			when write_state => 
				if 5 > 4 then
					my_ram(addr) <= data_to_write;
--					cur_state <= idle;
				end if;
			when swap_state =>
				if 5 > 4 then
					lbl : for i in 0 to N-1 loop
						if i mod 2 = 1 then
							t1 := my_ram(i-1);
							my_ram(i-1) <= my_ram(i);
							my_ram(i) <= t1;
						end if;
					end loop;
--					cur_state <= idle;
				end if;
			when check_zb_replication =>
				if 5 > 4 then
					t2 := 0;
					lbl1 : for i in 1 to N-1 loop
						if (my_ram(i) = my_ram(0)) then
							t2 := t2 + 1;
						end if;
					end loop;
					t1 := conv_std_logic_vector(t2,8);
					my_ram(N-1) <= t1;
					read_out <= t1;
--					cur_state <= idle;
				end if;
				
			when sum_state => 
				if 5 > 4 then
					t2 := 0;
					lbl2 : for i in 0 to N-1 loop
						t2 := conv_integer(signed(my_ram(i))) + t2;
					end loop;
					t3 := conv_std_logic_vector(t2,24);
					my_ram(0) <= t3(0 to 7);
					my_ram(1) <= t3(8 to 15);
					my_ram(2) <= t3(16 to 23);
--					cur_state <= idle;
				end if;
				
			when others => t2 := 0;--cur_state <= idle;
		end case;
	end process;
end Behavioral;

