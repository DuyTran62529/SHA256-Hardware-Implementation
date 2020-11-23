library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

--------------------------------------------------

entity tb_MUX64x1 is
end tb_MUX64x1;  

--------------------------------------------------

architecture tb_MUX64x1_arch of tb_MUX64x1 is

component MUX64x1
port(i: in std_logic_vector(0 to 63);
	c1, c2, c3, c4, c5, c6: in std_logic;
	o: out std_logic
);
end component;

signal i: std_logic_vector(0 to 63) := X"AAAAAAAAAAAAAAAA";
signal c1, c2, c3, c4, c5, c6: std_logic := '0';
signal o: std_logic;
constant hp : time := 10ns;

begin
	DUT: MUX64x1
	port map(
		i => i,
		c1 => c1,
		c2 => c2,
		c3 => c3,
		c4 => c4,
		c5 => c5,
		c6 => c6,
		o => o
	);

	c1 <= not c1 after hp;
	c2 <= not c2 after 2*hp;
	c3 <= not c3 after 4*hp;
	c4 <= not c4 after 8*hp;
	c5 <= not c5 after 16*hp;
	c6 <= not c6 after 32*hp;
	
	main: process
	begin
		wait for 64*hp;
		wait for 32*hp;
		stop;
	end process main;
	
end tb_MUX64x1_arch; 