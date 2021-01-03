library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity BitReg_32 is
port(i: in std_logic_vector (0 to 31);
	clk, load, t_c, t_i: in std_logic;
	o: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end BitReg_32;  

--------------------------------------------------

architecture BitReg_32_arch of BitReg_32 is

component MUX2x1
port(a, b: in std_logic;
	c: in std_logic;
	o: out std_logic
);
end component;

component FF_reg
port(i, t_i, clk, t_c: in std_logic;
	o, t_o: out std_logic
);
end component;

signal load_clk_mux_o: std_logic;
signal tmp: std_logic_vector (0 to 32);

begin
	u0: MUX2x1
	port map(
		a => load,
		b => clk,
		c => t_c,
		o => load_clk_mux_o
	);

	gen_reg: for j in 0 to 31 generate
		ux: FF_reg
		port map(
			i => i(j),
			t_i => tmp(j + 1),
			clk => load_clk_mux_o,
			t_c => t_c,
			o => o(j),
			t_o => tmp(j)
		);
	end generate gen_reg;
	
	tmp(32) <= t_i;
	t_o <= tmp(0);

end BitReg_32_arch;