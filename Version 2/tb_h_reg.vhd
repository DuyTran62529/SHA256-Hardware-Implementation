library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

--------------------------------------------------

entity tb_h_reg is
end tb_h_reg;  

--------------------------------------------------

architecture tb_h_reg_arch of tb_h_reg is

component h_reg
port(a, b, c, d, e, f, g, h: in std_logic_vector (0 to 31);
	clk, muxc, load, t_c, t_i: in std_logic; 
	o0, o1, o2, o3, o4, o5, o6, o7: out std_logic_vector (0 to 31);
	ma, mb, mc, md, me, mf, mg, mh: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end component;

signal a: std_logic_vector (0 to 31) := X"00000001";
signal b: std_logic_vector (0 to 31) := X"00000010";
signal c: std_logic_vector (0 to 31) := X"00000100";
signal d: std_logic_vector (0 to 31) := X"00001000";
signal e: std_logic_vector (0 to 31) := X"00010000";
signal f: std_logic_vector (0 to 31) := X"00100000";
signal g: std_logic_vector (0 to 31) := X"01000000";
signal h: std_logic_vector (0 to 31) := X"10000000";
signal clk, muxc, load, t_c, t_i: std_logic := '0'; 
signal o0, o1, o2, o3, o4, o5, o6, o7: std_logic_vector (0 to 31);
signal ma, mb, mc, md, me, mf, mg, mh: std_logic_vector (0 to 31);
signal t_o: std_logic;
constant hp: time := 5ns;

begin
	DUT: h_reg
	port map(
		a, b, c, d, e, f, g, h,
		clk, muxc, load, t_c, t_i, 
		o0, o1, o2, o3, o4, o5, o6, o7,
		ma, mb, mc, md, me, mf, mg, mh,
		t_o
	);

	clk <= not clk after hp;	

	main: process
	begin
		muxc <= '1';
		load <= '1';
		wait for 2*hp;
		muxc <= '0';
		load <= '0';
		wait for 2*hp;
		load <= '1';
		wait for 2*hp;
		load <= '0';
		wait for 10*hp;
		stop;
	end process main;
	
end tb_h_reg_arch; 