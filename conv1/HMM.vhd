----------------------------------------------------------------------------------
-- Company: 	
-- Engineer: 
-- 
-- Create Date:    08:44:21 12/09/2019 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.Int_Array.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HMM3 is
	generic(N : Integer := 2);
	Port(
		hmm_in1 : in int_arr3 := (2,3,0);
		hmm_in2 : in int_arr3 := (1,1,1);
		hmm_out : out int_arr3
	);
end HMM3; 

entity HMM5 is
	generic(N : Integer := 4);
	Port(
		hmm_in1 : in int_arr5;
		hmm_in2 : in int_arr5;
		hmm_out : out int_arr5
	);
end HMM5; 
 

entity HMM7 is
	generic(N : Integer := 6);
	Port(
		hmm_in1 : in int_arr7;
		hmm_in2 : in int_arr7;
		hmm_out : out int_arr7
	);
end HMM7; 

entity HMM9 is
	generic(N : Integer := 8);
	Port(
		hmm_in1 : in int_arr9;
		hmm_in2 : in int_arr9;
		hmm_out : out int_arr9
	);
end HMM9; 



architecture Behavioral3 of HMM3 is
--	type int_arr is array(N-1 downto 0) of integer;
begin	
	gen : for i in 0 to N generate
	--begin
		hmm_out(i) <= hmm_in1(i) * hmm_in2(i);
	end generate;
end Behavioral3;

architecture Behavioral5 of HMM5 is
--	type int_arr is array(N-1 downto 0) of integer;
begin	
	gen : for i in 0 to N generate
	--begin
		hmm_out(i) <= hmm_in1(i) * hmm_in2(i);
	end generate;
end Behavioral5;


architecture Behavioral7 of HMM7 is
--	type int_arr is array(N-1 downto 0) of integer;
begin	
	gen : for i in 0 to N generate
	--begin
		hmm_out(i) <= hmm_in1(i) * hmm_in2(i);
	end generate;
end Behavioral7;


architecture Behavioral9 of HMM9 is
--	type int_arr is array(N-1 downto 0) of integer;
begin	
	gen : for i in 0 to N generate
	--begin
		hmm_out(i) <= hmm_in1(i) * hmm_in2(i);
	end generate;
end Behavioral9;
