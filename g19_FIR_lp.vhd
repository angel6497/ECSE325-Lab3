library IEEE;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity g19_FIR_lp is 
	port ( x: in std_logic_vector (2 downto 0);
			clk ,rst: in std_logic;
			y: out std_logic_vector(3 downto 0));
end g19_FIR_lp;

architecture lab3 of g19_FIR_lp is
signal registers: std_logic_vector(74 downto 0);--declaring the registers that would be used
signal coefficient: std_logic_vector(74 downto 0);-- declaring a signal to hold the coefficients 
signal sum: signed(5 downto 0);--holds the sum of the products
begin 
	coefficient<= "000"& -- initializing the coefficients 
"000"&
"000"&
"000"&
"000"&
"000"&
"000"&
"000"&
"111"&
"000"&
"000"&
"111"&
"001"&
"111"&
"000"&
"000"&
"111"&
"000"&
"000"&
"000"&
"000"&
"000"&
"000"&
"000"&
"000";
	y<=std_logic_vector(sum(5 downto 2));-- y holds the 17 MSBs of the sum
	process(clk, rst)
	variable mac: signed(5 downto 0);-- declaring a variable to compute the sum
	begin 
		mac:=(others=>'0');
		for i in 0 to 24 loop -- computing the sum of products 
				mac:=mac+signed(registers(2+3*i downto 3*i))*signed(coefficient(2+3*i downto 3*i));
		end loop;
		if rst='1' then -- asynchronous reset
			registers<=(others=>'0');
			sum<=(others=>'0');
		elsif rising_edge(clk) then
			for i in 0 to 23 loop -- shifting registers
				registers(2+3*(i+1)  downto 3*(i+1) )<=registers( 2+3*i downto 3*i);
			end loop;
			registers(2 downto 0)<=x;--putting the input in the first register
			sum<=mac;
		end if;
	end process;
	
end lab3;
