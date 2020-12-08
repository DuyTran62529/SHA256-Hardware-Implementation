library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

--------------------------------------------------

entity tb_SHA256 is
end tb_SHA256;  

--------------------------------------------------

architecture tb_SHA256_arch of tb_SHA256 is

component SHA256
port(i: in std_logic_vector (0 to 511);
	o0, o1, o2, o3, o4, o5, o6, o7: out std_logic_vector(0 to 31);
	start, rst, initial: in std_logic;
	clk: in std_logic;
	ready: out std_logic;

	t_c, t_i: in std_logic;
	t_o: out std_logic
);
end component;

signal start, rst, initial: std_logic := '0';

signal i: std_logic_vector (0 to 511) := X"80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

--X"616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161618000000000000001B8"--

signal clk: std_logic := '0';
signal t_c, t_i: std_logic := '0';
signal o0, o1, o2, o3, o4, o5, o6, o7: std_logic_vector (0 to 31);
signal ready, t_o: std_logic;

constant hp: time := 5ns;

begin
	DUT: SHA256
	port map(
		i => i,
		o0 => o0, o1 => o1, o2 => o2, o3 => o3, o4 => o4, o5 => o5, o6 => o6, o7 => o7,
		start => start, rst => rst, initial => initial,
		clk => clk,
		ready => ready,

		t_c => t_c, t_i => t_i,
		t_o => t_o
	);

	clk <= not clk after hp;	

	main: process
	begin
		t_c <= '1';
		wait for 14*hp;
		t_c <= '0';
		start <= '1';
		initial <= '1';
		wait for 2*hp;
		start <= '0';
		initial <= '0';

		wait for 2*hp;
		while (ready = '0') loop
			wait for 2*hp;
		end loop;

		wait for 14*hp;
		stop;
	end process main;
	
end tb_SHA256_arch; 