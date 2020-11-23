library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

--------------------------------------------------

entity tb_RRo_mod is
end tb_RRo_mod;  

--------------------------------------------------

architecture tb_RRo_mod_arch of tb_RRo_mod is

component RRo_mod
port(a, b, c, d: in std_logic;
	c1, c2, c1n, c2n: in std_logic;
	o: out std_logic
);
end component;

signal a, b, c, d: std_logic := '0';
signal c1, c2: std_logic := '0';
signal c1n, c2n: std_logic;
signal o: std_logic;
constant hp : time := 10ns;

begin
	DUT: RRo_mod
	port map(
		a => a,
		b => b,
		c => c,
		d => d,
		c1 => c1,
		c2 => c2,
		c1n => c1n,
		c2n => c2n,
		o => o
	);

	inv_c: process(c1, c2)
	begin
		c1n <= not c1;
		c2n <= not c2;
	end process inv_c;

	a <= not a after hp;

	b <= not b after 2*hp;

	c <= not c after 4*hp;

	d <= not d after 8*hp;
	
	main: process
	begin
		wait for 16*hp;

		c2 <= '1';

		wait for 16*hp;

		c1 <= '1';
		c2 <= '0';

		wait for 16*hp;

		c2 <= '1';

		wait for 16*hp;

		stop;
	end process main;

	
end tb_RRo_mod_arch; 