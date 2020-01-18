library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;

entity Ram_Top is
	Port(
		opc  : std_logic_vector(0 to 7); -- checks what to do states from left to right enumerated
		clk  : std_logic; 
		addr : std_logic_vector(0 to 9);
		data : std_logic_vector(0 to 7);
		res  : out std_logic_vector(0 to 23)
	);
end Ram_Top;

architecture Behavioral of Ram_Top is

	component Ram_1KB is
		Generic(
			N : integer := 1024;
			Block_Size : integer := 8
		);
		Port(
			to_do : integer ;
			data_to_write : in std_logic_vector(0 to Block_Size-1);
			addr : in integer; -- ten bits for 1024 block of ram
			write_ena: in std_logic;
			clk : in std_logic; -- for checking the states
			read_out : out std_logic_vector(0 to Block_Size-1)
		);
	end component Ram_1KB;
	type ram is array(0 to N-1) of std_logic_vector(0 to Block_Size-1);
	type state is (idle, read_state, write_state, swap_state, sum_state, check_zb_replication);
	-- 0 idle 				: nothing to do
	-- 1 read_state     : reads the addr block and put in read_out
	-- 2 write_state    : if write enable is on writes the data_to_write on addr block
	-- 3 swap_state     : swap all odds and evens blocks
	-- 4 sum_state      : sums all the blocks and save it completely it may need more than one byte
	-- 5 zb_replication : checks the count of replication of zero block of ram
	signal cur_state : state := idle;
	signal nxt_state : state;
	signal write_ena : std_logic := '0';
	signal to_do : integer;
	signal output : std_logic_vector(0 to 7);
begin

	myram : Ram_1KB Generic map(
			N => 1024,
			Block_Size => 8
	)	port map(
			to_do => to_do, -- 1 read 2 write
			data_to_write => data,
			addr => addr,
			write_ena => write_ena,
			clk => clk,
			read_out => output
	);

	process(clk)
	begin
		if (clk'event) and (clk = '1') then
			cur_state <= nxt_state;
		end if;
	end process;
	
	process(cur_state, opc)
		variable t1 : std_logic_vector(0 to 7);
		variable t2 : std_logic_vector(0 to 7);
		variable t3 : std_logic_vector(0 to 23);
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
					when others => NULL;
				end case;
			when read_state => 
					read_out <= my_ram(addr);
					nxt_state <= idle;
			when write_state => 
					my_ram(addr) <= data_to_write;
					nxt_state <= idle;
			when swap_state =>
					lbl : for i in 0 to N-1 loop
						if i mod 2 = 1 then
							t1 := my_ram(i-1);
							my_ram(i-1) <= my_ram(i);
							my_ram(i) <= t1;
						end if;
					end loop;
					nxt_state <= idle;
			when check_zb_replication =>
					t2 := 0;
					lbl1 : for i in 1 to N-1 loop
						if (my_ram(i) = my_ram(0)) then
							t2 := t2 + 1;
						end if;
					end loop;
					t1 := conv_std_logic_vector(t2,8);
					my_ram(N-1) <= t1;
					read_out <= t1;
					nxt_state <= idle;
				
			when sum_state => 
					t2 := 0;
					lbl2 : for i in 0 to N-1 loop
						t2 := conv_integer(signed(my_ram(i))) + t2;
					end loop;
					t3 := conv_std_logic_vector(t2,24);
					my_ram(0) <= t3(0 to 7);
					my_ram(1) <= t3(8 to 15) when  t3(8 to 15) /= 0;
					my_ram(2) <= t3(16 to 23) when t3(16 to 23) /= 0;
					nxt_state <= idle;
				
			when others => t2 := 0;--cur_state <= idle;
		end case;
	end process;

end Behavioral;

