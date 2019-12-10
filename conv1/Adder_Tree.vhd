----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:44:21 12/09/2019 
-- Comment : 
	-- we did it wrongly. check the architecture then implement it
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Library work;
use work.Int_Array.all;


entity Adder_Tree_2_to_1 is
	Port(
		in_1 : integer;
		in_2 : integer;
		out_1 : integer
	);
end entity;

entity Adder_Tree3 is
	generic(N : integer := 2);
	Port(
		in1 : in int_arr3 ;
		in2 : in int_arr3 ;
		in3 : in int_arr3 ;
		conv_res : out integer
	);

end Adder_Tree3;


entity Adder_Tree5 is
	generic(N : integer := 4);
	Port(
		in1 : in int_arr5 ;
		in2 : in int_arr5 ;
		in3 : in int_arr5 ;
		in4 : in int_arr5 ;
		in5 : in int_arr5 ;
		conv_res : out integer
	);

end Adder_Tree5;

entity Adder_Tree7 is
	generic(N : integer := 6);
	Port(
		in1 : in int_arr7 ;
		in2 : in int_arr7 ;
		in3 : in int_arr7 ;
		in4 : in int_arr7 ;
		in5 : in int_arr7 ;
		in6 : in int_arr7 ;
		in7 : in int_arr7 ;
		conv_res : out integer
	);
end Adder_Tree7;
 
entity Adder_Tree9 is
	generic(N : integer := 8);
	Port(
		in1 : in int_arr9 ;
		in2 : in int_arr9 ;
		in3 : in int_arr9 ;
		in4 : in int_arr9 ;
		in5 : in int_arr9 ;
		in6 : in int_arr9 ;
		in7 : in int_arr9 ;
		in8 : in int_arr9 ;
		in9 : in int_arr9 ;
		conv_res : out integer
	);
end Adder_Tree9;

architecture Adder_Tree of Adder_Tree_2_to_1 is
begin
	out_1 <= in_1 + in_2;
end;

architecture Behavioral3 of Adder_Tree is
begin
	process(in1,in2,in3) 
		variable temp : integer := 0;
	begin
		for i in 0 to N loop
			temp := temp + in1(i);
			temp := temp + in2(i);
			temp := temp + in3(i);
		end loop;
		conv_res <= temp;
	end process;
end Behavioral3;
-- for adding behaviorals we have to change the number of lines

architecture Behavioral5 of Adder_Tree5 is
begin
	process(in1,in2,in3,in4,in5) 
		variable temp : integer := 0;
	begin
		for i in 0 to N loop
			temp := temp + in1(i);
			temp := temp + in2(i);
			temp := temp + in3(i);
			temp := temp + in4(i);
			temp := temp + in5(i);
		end loop;
		conv_res <= temp;
	end process;
end Behavioral5;

architecture Behavioral7 of Adder_Tree7 is
begin
	process(in1,in2,in3,in4,in5,in6,in7) 
		variable temp : integer := 0;
	begin
		for i in 0 to N loop
			temp := temp + in1(i);
			temp := temp + in2(i);
			temp := temp + in3(i);
			temp := temp + in4(i);
			temp := temp + in5(i);
			temp := temp + in6(i);
			temp := temp + in7(i);
		end loop;
		conv_res <= temp;
	end process;
end Behavioral7;

architecture Behavioral9 of Adder_Tree9 is
begin
	process(in1,in2,in3,in4,in5,in6,in7,in8,in9) 
		variable temp : integer := 0;
	begin
		for i in 0 to N loop
			temp := temp + in1(i);
			temp := temp + in2(i);
			temp := temp + in3(i);
			temp := temp + in4(i);
			temp := temp + in5(i);
			temp := temp + in6(i);
			temp := temp + in7(i);
			temp := temp + in8(i);
			temp := temp + in9(i);
		end loop;
		conv_res <= temp;
	end process;
end Behavioral9;
