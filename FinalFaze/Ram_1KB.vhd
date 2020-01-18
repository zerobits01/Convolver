library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Ram_1KB is
	Generic(
		N : integer := 1024;
		Block_Size : integer := 8
	);
	Port(
		data_to_write : in std_logic_vector(0 to Block_Size-1);
		addr : in integer range 0 to N-1; -- ten bits for 1024 block of ram
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
	signal nxt_state : state := idle;
	shared variable my_ram : ram := ("11000001", "00000001",others => (others => '0')); -- because after reset ram will be cleared
begin

	process(clk)
	begin 
		if rising_edge(clk) then
			cur_state <= nxt_state;
		end if;
	end process;

	process(cur_state, to_do)
		variable t1 : std_logic_vector(0 to 7);
		variable t2 : integer := 0;
		variable t3 : std_logic_vector(0 to 23) := (others => '0');
		variable counter : integer := 0;
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
					when 3 =>
						nxt_state <= swap_state;
					when 4 =>
						nxt_state <= sum_state;
					when 5 =>
						nxt_state <= check_zb_replication;
					when others => Null;
				end case;

			when read_state => 
					read_out <= my_ram(addr);
					nxt_state <= idle;

			when write_state => 
					my_ram(addr) := data_to_write;
					nxt_state <= idle;

			when swap_state =>
					if counter < 1024 then
						if counter mod 2 = 1 then
							assert false
								report "here i am"
							severity Note;
							t1 := my_ram(counter-1);
							my_ram(counter-1) := my_ram(counter);
							my_ram(counter) := t1;
						end if;
						counter := counter + 1;
						nxt_state <= swap_state;
					else
						counter := 0;
						nxt_state <= idle;
					end if;
			when check_zb_replication =>
					for i in 0 to N-1 loop
						if (my_ram(i) = my_ram(0)) then
							t2 := t2 + 1;
						end if;
					end loop;
--					if counter < 1024 then
--						if (my_ram(counter) = my_ram(0)) then
--								t2 := t2 + 1;
--						end if;
--						counter := counter + 1;
--					else
						t1 := conv_std_logic_vector(t2,8);
						my_ram(N-1) := t1;
						read_out <= t1;
						--t1 := (others => '0');
						nxt_state <= idle;
						counter := 0;
						t2 := 0;				
--					end if;
			when sum_state =>
					for i in 0 to 5 loop
							t2 := conv_integer(unsigned(my_ram(i))) + t2;
							assert false
								report integer'image(t2)
							severity Note;	
					end loop;
--					if counter < 1024 then
--						assert false
--							report "here i am"
--						severity Note;
--						t2 := conv_integer(unsigned(my_ram(counter))) + t2;
--						nxt_state <= sum_state;
--						counter := counter + 1;
--					else
						t3 := conv_std_logic_vector(t2,24);
						my_ram(0) := t3(16 to 23);
						if t3(8 to 15) /= "00000000" then
							my_ram(1) := t3(8 to 15);
						end if;
						if t3(0 to 7) /= "00000000" then
							my_ram(2) := t3(16 to 23);
						end if;
						read_out <= t3(16 to 23);
						counter := 0;
						t2 := 0;
						nxt_state <= idle;
--					end if;

			when others => NULL;nxt_state <= idle;
		end case;
	end process;
end Behavioral;

