library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

--------------------------------------------------

entity tb_MUX8x1 is
end tb_MUX8x1;  

--------------------------------------------------

architecture tb_MUX8x1_arch of tb_MUX8x1 is

component MUX8x1
port(i: in std_logic_vector(0 to 7);
	c1, c2, c3: in std_logic;
	o: out std_logic
);
end component;

signal i: std_logic_vector(0 to 7) := "01100101";
signal c1, c2, c3: std_logic := '0';
signal o: std_logic;
constant hp : time := 50ns;

begin
	DUT: MUX8x1
	port map(
		i => i,
		c1 => c1,
		c2 => c2,
		c3 => c3,
		o => o
	);
	
	main: process
	begin
		wait for hp;

		c1 <= '1';

		wait for hp;

		c2 <= '1';
		c1 <= '0';

		wait for hp;
		
		c1 <= '1';

		wait for hp;

		c3 <= '1';
		c2 <= '0';
		c1 <= '0';

		wait for hp;

		c1 <= '1';

		wait for hp;

		c2 <= '1';
		c1 <= '0';

		wait for hp;
		
		c1 <= '1';

		wait for hp;

		stop;
	end process main;

end tb_MUX8x1_arch; 