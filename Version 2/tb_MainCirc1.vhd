library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

--------------------------------------------------

entity tb_MainCirc1 is
end tb_MainCirc1;  

--------------------------------------------------

architecture tb_MainCirc1_arch of tb_MainCirc1 is

component MainCirc1
port(i: in std_logic_vector (0 to 511);
	clk: in std_logic;
	t_c, t_i: in std_logic;
	t_o: out std_logic;
	mux_2: out std_logic_vector(0 to 31);

	mux_dmux_c: in std_logic_vector(0 to 5);
	loadwreg: in std_logic;
	loadreg_16_63: in std_logic
);
end component;

signal i: std_logic_vector (0 to 511) := X"A0000000B0000000000000000000000000000000000000000000000000000000C00000000000000000000000000000000000000000000000D000000000000000";
signal clk, t_c, t_i: std_logic := '0';
signal mux_dmux_c: std_logic_vector (0 to 5) := "000000";
signal loadwreg: std_logic := '0';
signal loadreg_16_63: std_logic := '0';
signal mux_2: std_logic_vector (0 to 31);
signal t_o: std_logic;
constant hp: time := 5ns;

begin
	DUT: MainCirc1
	port map(
		i => i,
		clk => clk,
		t_c => t_c, t_i => t_i,
		t_o => t_o,
		mux_2 => mux_2,

		mux_dmux_c => mux_dmux_c,
		loadwreg => loadwreg,
		loadreg_16_63 => loadreg_16_63
	);

	clk <= not clk after hp;

	main: process
	begin
		loadwreg <= '1';
		wait for 2*hp;

		loadwreg <= '0';
		loadreg_16_63 <= '1';
		wait for 2*hp;

		loadreg_16_63 <= '0';
		mux_dmux_c <= "000001";
		wait for 2*hp;

		loadreg_16_63 <= '1';
		wait for 2*hp;

		loadreg_16_63 <= '0';
		mux_dmux_c <= "000010";
		wait for 2*hp;

		loadreg_16_63 <= '1';
		wait for 2*hp;

		loadreg_16_63 <= '0';
		wait for 10*hp;
		stop;
	end process main;
	
end tb_MainCirc1_arch; 