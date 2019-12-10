library IEEE;
use IEEE.STD_LOGIC_1164.all;

package Int_Array is

	generic (N : integer := 3);
	type int_arr is array(0 to N);
	type int_arr3 is array(0 to 2) of integer;
	type int_arr5 is array(0 to 4) of integer;
	type int_arr7 is array(0 to 6) of integer;
	type int_arr9 is array(0 to 8) of integer;
	type int_arr10 is array(0 to 9) of integer;
	type int_arr26 is array(0 to 25) of integer;
	type int_arr50 is array(0 to 49) of integer;
	type int_arr82 is array(0 to 81) of integer;

	type int_mat3 is array(0 to 2) of int_arr3;
	type int_mat5 is array(0 to 4) of int_arr5;
	type int_mat7 is array(0 to 6) of int_arr7;
	type int_mat9 is array(0 to 8) of int_arr9;
	
	
end Int_Array;

package body Int_Array is

 
end Int_Array;
