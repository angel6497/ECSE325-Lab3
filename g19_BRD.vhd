library IEEE;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity g19_BRD is 
	port ( x: in std_logic_vector (15 downto 0);
			clk ,rst: in std_logic;
			y: out std_logic_vector(16 downto 0));
end g19_BRD;

architecture lab3 of g19_BRD is
signal registers: signed(424 downto 0);--declaring the registers that would be used
signal coefficient: std_logic_vector(399 downto 0);-- declaring a signal to hold the coefficients 
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
	
	process(clk, rst)
	variable mul: signed(31 downto 0);-- declaring a variable to compute the products
	begin 
		mul:=(others=>'0');
		if rst='1' then -- asynchronous reset
			registers<=(others=>'0');
		elsif rising_edge(clk) then
			-- computing the products of x with the coefficients
			-- each registers include sum of the product and the previous register
			mul:=signed(x)*signed(coefficient(399 downto 384));
			registers(424 downto 408)<= mul(31 downto 15); 
			for i in 0 to 23 loop
				mul:=signed(x)*signed(coefficient(399-16*(i+1) downto 384-16*(i+1)));
				registers(407-17*i  downto 408-17*(i+1) )<=registers(424-17*i  downto 425-17*(i+1))+mul(31 downto 15);
			end loop;
			y<=std_logic_vector(registers(16  downto 0));-- y holds the value of the first register
		end if;
	end process;
	
end lab3;
