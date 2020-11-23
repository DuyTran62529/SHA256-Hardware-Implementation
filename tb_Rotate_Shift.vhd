library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

--------------------------------------------------

entity tb_Rotate_Shift is
end tb_Rotate_Shift;  

--------------------------------------------------

architecture tb_Rotate_Shift_arch of tb_Rotate_Shift is

component Rotate_Shift
port(i: in std_logic_vector(0 to 31);
	rc1, rc2: std_logic;
	sen, sc: std_logic;
	o: out std_logic_vector(0 to 31)
);
end component;

signal i: std_logic_vector(0 to 31) := x"80000000";
signal rc1, rc2, sen, sc: std_logic := '0';
signal o: std_logic_vector(0 to 31);
constant hp : time := 50ns;

begin
	DUT: Rotate_Shift
	port map(
		i => i,
		rc1 => rc1,
		rc2 => rc2,
		sen => sen,
		sc => sc,
		o => o
	);
	
	main: process
	begin
		wait for hp;

		i <= x"80000000";
		rc2 <= '1';

		wait for hp;

		i <= x"80000000";
		rc1 <= '1';
		rc2 <= '0';

		wait for hp;

		i <= x"80000000";		
		rc2 <= '1';

		wait for hp;

		i <= x"00000001";		

		wait for hp;

		i <= x"FFFFFFFF";
		sen <= '1';

		wait for hp;

		i <= x"FFFFFFFF";
		sc <= '1';

		wait for hp;

		stop;
	end process main;

	
end tb_Rotate_Shift_arch; 