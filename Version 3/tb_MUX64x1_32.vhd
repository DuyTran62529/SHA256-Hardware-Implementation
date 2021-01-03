library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

--------------------------------------------------

entity tb_MUX64x1_32 is
end tb_MUX64x1_32;  

--------------------------------------------------

architecture tb_MUX64x1_32_arch of tb_MUX64x1_32 is

component MUX64x1_32
port(i: in std_logic_vector (0 to 2047);
	c: in std_logic_vector (0 to 5);
	o: out std_logic_vector (0 to 31)
);
end component;

signal i: std_logic_vector(0 to 2047) := X"FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000";

signal c: std_logic_vector(0 to 5) := "000000";
signal o: std_logic_vector(0 to 31);
constant hp : time := 10ns;

begin
	DUT: MUX64x1_32
	port map(
		i => i,
		c => c, 
		o => o
	);

	c(5) <= not c(5) after hp;
	c(4) <= not c(4) after 2*hp;
	c(3) <= not c(3) after 4*hp;
	c(2) <= not c(2) after 8*hp;
	c(1) <= not c(1) after 16*hp;
	c(0) <= not c(0) after 32*hp;
	
	main: process
	begin
		wait for 64*hp;
		wait for 32*hp;
		stop;
	end process main;
	
end tb_MUX64x1_32_arch; 