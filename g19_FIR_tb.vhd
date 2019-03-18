library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity g19_FIR_tb is
end g19_FIR_tb;

architecture test of g19_FIR_tb is
	signal x_in :  std_logic_vector(15 downto 0);--w=10 F=7
	signal clk_in, rst_in:  std_logic;
	signal FIR_out:  std_logic_vector(16 downto 0);
	component g19_BRD is
	port (x: in std_logic_vector (15 downto 0);
			clk ,rst: in std_logic;
			y: out std_logic_vector(16 downto 0));
	end component g19_BRD;
	file file_VECTORS_X :text;
	file file_RESULTS :text;
	
	constant clk_PERIOD : time := 100 ns;
	
	
	
	begin 
		g19_FIR_INST : g19_BRD
			port map (
				x => x_in,
				clk => clk_in,
				rst => rst_in,
				y=>FIR_out
				);
		clk_generation: process
		begin 
			clk_in<='1';
			wait for clk_PERIOD;
			clk_in<='0';
			wait for clk_PERIOD;
		end process clk_generation;
		feeding_instr :process 
			variable v_lline1 :line;

			variable v_Oline :line;
			variable v_x_in:  std_logic_vector(15 downto 0);
			
			
		begin 
 			rst_in<='1';
			
			x_in<=(others=>'0');
			wait until rising_edge(clk_in);
wait until rising_edge(clk_in);
			--wait until falling_edge(clk_in);
			rst_in<='0';
		        file_open(file_VECTORS_X, "input.txt", read_mode);
			file_open(file_RESULTS, "output.txt", write_mode);
			
			while not endfile(file_VECTORS_X) loop
				
				readline(file_VECTORS_X, v_lline1);
				read(v_lline1, v_x_in);

				x_in<=v_x_in;
				
				wait until rising_edge(clk_in);
				write(v_Oline, FIR_out);
				writeline(file_RESULTS, v_Oline);
			end loop;
			wait;
			
			
		end process feeding_instr;
end test;