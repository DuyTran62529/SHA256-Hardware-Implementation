library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

--------------------------------------------------

entity tb_w_reg is
end tb_w_reg;  

--------------------------------------------------

architecture tb_w_reg_arch of tb_w_reg is

component w_reg
port(i_0_15: in std_logic_vector (0 to 511);
	i_16_63: in std_logic_vector (0 to 31);
	clk, load16, load48, t_c, t_i: in std_logic;
	load48dmux: in std_logic_vector(0 to 5); 
	o: out std_logic_vector (0 to 2047);
	t_o: out std_logic
);
end component;

signal i_0_15: std_logic_vector (0 to 511) := X"A000000AB000000BA000000AB000000BA000000AB000000BA000000AB000000BA000000AB000000BA000000AB000000BA000000AB000000BA000000AB000000B";
signal i_16_63: std_logic_vector (0 to 31) := X"80000001";
signal clk, load16, load48, t_c, t_i: std_logic := '0';
signal load48dmux: std_logic_vector(0 to 5) := "010000"; 
signal o: std_logic_vector (0 to 2047);
signal t_o: std_logic;
constant hp: time := 5ns;

begin
	DUT: w_reg
	port map(
		i_0_15,
		i_16_63,
		clk, load16, load48, t_c, t_i,
		load48dmux, 
		o,
		t_o
	);

	clk <= not clk after hp;
	load48dmux(5) <= not load48dmux(5) after 2*hp;
	load48dmux(4) <= not load48dmux(4) after 4*hp;
	load48dmux(3) <= not load48dmux(3) after 8*hp;
	load48dmux(2) <= not load48dmux(2) after 16*hp;
	load48dmux(1) <= not load48dmux(1) after 32*hp;
	load48dmux(0) <= not load48dmux(0) after 64*hp;	

	main: process
	begin
		load48 <= '1';
		wait for 128*hp;
		i_16_63 <= X"B000000C";
		load48 <= '0';
		load16 <= '1';
		wait for 32*hp;
		stop;
	end process main;
	
end tb_w_reg_arch; 