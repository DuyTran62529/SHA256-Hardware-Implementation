library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

--------------------------------------------------

entity tb_BitReg_32 is
end tb_BitReg_32;  

--------------------------------------------------

architecture tb_BitReg_32_arch of tb_BitReg_32 is

component BitReg_32
port(i: in std_logic_vector (0 to 31);
	clk, load, t_c, t_i: in std_logic;
	o: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end component;

signal i: std_logic_vector(0 to 31) := X"FFFFFFFE";

signal clk, t_i, load: std_logic := '0';
signal t_c: std_logic := '1';
signal o: std_logic_vector(0 to 31);
signal t_o: std_logic;
constant hp : time := 10ns;

begin
	DUT: BitReg_32
	port map(
		i => i,
		clk => clk,
		load => load,
		t_c => t_c,
		t_i => t_i,
		o => o,
		t_o => t_o 
	);

	clk <= not clk after hp;
	t_i <= not t_i after 2*hp;
	
	main: process
	begin
		wait for 96*hp;
		t_c <= '0';
		load <= '1';
		wait for 32*hp;
		load <= '0';
		i <= X"00000001";
		wait for 32*hp;
		load <= '1';
		wait for 32*hp;
		stop;
	end process main;
	
end tb_BitReg_32_arch; 