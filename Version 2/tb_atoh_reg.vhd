library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

--------------------------------------------------

entity tb_atoh_reg is
end tb_atoh_reg;  

--------------------------------------------------

architecture tb_atoh_reg_arch of tb_atoh_reg is

component atoh_reg
port(h0, h1, h2, h3, h4, h5, h6, h7: in std_logic_vector (0 to 31);
	clk, muxc, load, t_c, t_i: in std_logic; 
	temp1, temp2: in std_logic_vector (0 to 31);
	a, b, c, d, e, f, g, h: out std_logic_vector (0 to 31);
	main_a, main_e, main_h: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end component;

signal h0: std_logic_vector (0 to 31) := X"00000001";
signal h1: std_logic_vector (0 to 31) := X"00000010";
signal h2: std_logic_vector (0 to 31) := X"00000100";
signal h3: std_logic_vector (0 to 31) := X"00001000";
signal h4: std_logic_vector (0 to 31) := X"00010000";
signal h5: std_logic_vector (0 to 31) := X"00100000";
signal h6: std_logic_vector (0 to 31) := X"01000000";
signal h7: std_logic_vector (0 to 31) := X"10000000";
signal clk, muxc, load, t_c, t_i: std_logic := '0'; 
signal temp1: std_logic_vector (0 to 31) := X"00000111";
signal temp2: std_logic_vector (0 to 31) := X"11111000";
signal a, b, c, d, e, f, g, h: std_logic_vector (0 to 31);
signal main_a, main_e, main_h: std_logic_vector (0 to 31);
signal t_o: std_logic;
constant hp: time := 5ns;

begin
	DUT: atoh_reg
	port map(
		h0, h1, h2, h3, h4, h5, h6, h7,
		clk, muxc, load, t_c, t_i,
		temp1, temp2,
		a, b, c, d, e, f, g, h,
		main_a, main_e, main_h,
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
	
end tb_atoh_reg_arch; 