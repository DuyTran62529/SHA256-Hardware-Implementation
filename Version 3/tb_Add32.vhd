library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

--------------------------------------------------

entity tb_Add32 is
end tb_Add32;  

--------------------------------------------------

architecture tb_Add32_arch of tb_Add32 is

constant bl: integer := 32;

component Add32
port(a, b: in std_logic_vector(0 to (bl-1));
	o: out std_logic_vector(0 to (bl-1))
);
end component;

signal a: std_logic_vector(0 to (bl-1)) := x"7FFFFFFF";
signal b: std_logic_vector(0 to (bl-1)) := x"00000001";
signal o: std_logic_vector(0 to (bl-1));
constant hp : time := 50ns;

begin
	DUT: Add32
	port map(
		a => a,
		b => b,
		o => o
	);
	
	main: process
	begin
		wait for 10ns;
		a <= x"55555555";
		b <= x"AAAAAAAA";
		wait for 10ns;
		stop;
	end process main;

	
end tb_Add32_arch; 