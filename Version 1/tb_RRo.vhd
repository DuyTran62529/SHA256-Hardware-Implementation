library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

--------------------------------------------------

entity tb_RRo is
end tb_RRo;  

--------------------------------------------------

architecture tb_RRo_arch of tb_RRo is

component RRo
port(i: in std_logic_vector(0 to 31);
	c1, c2: in std_logic;
	o: out std_logic_vector(0 to 31)
);
end component;

signal i: std_logic_vector(0 to 31) := x"80000000";
signal c1, c2: std_logic := '0';
signal o: std_logic_vector(0 to 31);
constant hp : time := 50ns;

begin
	DUT: RRo
	port map(
		i => i,
		c1 => c1,
		c2 => c2,
		o => o
	);
	
	main: process
	begin
		wait for hp;

		i <= x"80000000";
		c2 <= '1';

		wait for hp;

		i <= x"80000000";
		c1 <= '1';
		c2 <= '0';

		wait for hp;

		i <= x"80000000";		
		c2 <= '1';

		wait for hp;

		stop;
	end process main;

	
end tb_RRo_arch; 