library IEEE;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity g19_FIR2 is 
	port ( x: in std_logic_vector (15 downto 0);
			clk ,rst: in std_logic;
			y: out std_logic_vector(16 downto 0));
end g19_FIR2;

architecture lab3 of g19_FIR2 is
signal registers: std_logic_vector(399 downto 0);
signal coefficient: std_logic_vector(399 downto 0);
signal sum: signed(31 downto 0);
begin 
	coefficient<= "0000010000000000"&
"0000000000000000"&
"0000000000000000"&
"0000000000000000"&
"0000010000000000"&
"1111110000000000"&
"1111110000000000"&
"0000110000000000"&
"1110110000000000"&
"0000110000000000"&
"0000010000000000"&
"1110110000000000"&
"0010000000000000"&
"1110110000000000"&
"0000010000000000"&
"0000110000000000"&
"1110110000000000"&
"0000110000000000"&
"1111110000000000"&
"1111110000000000"&
"0000010000000000"&
"0000000000000000"&
"0000000000000000"&
"0000000000000000"&
"0000010000000000";
	y<=std_logic_vector(sum(31 downto 15));
	process(clk, rst)
	variable mac: signed(31 downto 0);
	begin 
		mac:=(others=>'0');
		for i in 0 to 24 loop
				mac:=mac+signed(registers(15+16*i downto 16*i))*signed(coefficient(15+16*i downto 16*i));
		end loop;
		if rst='1' then 
			registers<=(others=>'0');
		elsif rising_edge(clk) then
			for i in 0 to 23 loop
				registers(15+16*(i+1)  downto 16*(i+1) )<=registers( 15+16*i downto 16*i);
			end loop;
			registers(15 downto 0)<=x;
			sum<=mac;
		end if;
	end process;
	
end lab3;
