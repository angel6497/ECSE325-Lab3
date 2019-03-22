library IEEE;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity g19_FIR is 
	port ( x: in std_logic_vector (15 downto 0);
			clk ,rst: in std_logic;
			y: out std_logic_vector(16 downto 0));
end g19_FIR;

architecture lab3 of g19_FIR is
signal registers: std_logic_vector(399 downto 0);--declaring the registers that would be used
signal coefficient: std_logic_vector(399 downto 0);-- declaring a signal to hold the coefficients 
signal sum: signed(31 downto 0);--holds the sum of the products
begin 
	coefficient<= "0000001001110011"& -- initializing the coefficients 
"0000000000010001"&
"1111111111010010"&
"1111111011011101"&
"0000001100011010"&
"1111110110100111"&
"1111110000001101"&
"0000110110111101"&
"1110110001110010"&
"0000110111111000"&
"0000001100001000"&
"1110101000001010"&
"0001111000110100"&
"1110101000001010"&
"0000001100001000"&
"0000110111111000"&
"1110110001110010"&
"0000110110111101"&
"1111110000001101"&
"1111110110100111"&
"0000001100011010"&
"1111111011011101"&
"1111111111010010"&
"0000000000010001"&
"0000001001110011";
	y<=std_logic_vector(sum(31 downto 15));-- y holds the 17 MSBs of the sum
	process(clk, rst)
	variable mac: signed(31 downto 0);-- declaring a variable to compute the sum
	begin 
		mac:=(others=>'0');
		for i in 0 to 24 loop -- computing the sum of products 
				mac:=mac+signed(registers(15+16*i downto 16*i))*signed(coefficient(15+16*i downto 16*i));
		end loop;
		if rst='1' then -- asynchronous reset
			registers<=(others=>'0');
			sum<=(others=>'0');
		elsif rising_edge(clk) then
			for i in 0 to 23 loop -- shifting registers
				registers(15+16*(i+1)  downto 16*(i+1) )<=registers( 15+16*i downto 16*i);
			end loop;
			registers(15 downto 0)<=x; --putting the input in the first register
			sum<=mac;
		end if;
	end process;
	
end lab3;
