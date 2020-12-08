library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity LoopIndex is
port(i: in std_logic_vector (0 to 5);
	load, t_c, t_i, clk: in std_logic;
	t_o: out std_logic;
	o: out std_logic_vector (0 to 5)
);
end LoopIndex;  

--------------------------------------------------

architecture LoopIndex_arch of LoopIndex is

component OR2x1
port(x, y: in std_logic;
	o: out std_logic
);
end component;

component AND2x1
port(x, y: in std_logic;
	o: out std_logic
);
end component;

component FF_reg
port(i, t_i, clk, t_c: in std_logic;
	o, t_o: out std_logic
);
end component;

signal load_or, load_and: std_logic;
signal tmp: std_logic_vector (0 to 6);


begin
	u0: OR2x1
	port map(
		x => load,
		y => t_c,
		o => load_or
	);

	u1: AND2x1
	port map
	(
		x => load_or, 
		y => clk,
		o => load_and
	);

	gen_reg: for j in 0 to 5 generate
		ux: FF_reg
		port map(
			i => i(j),
			t_i => tmp(j + 1),
			clk => load_and,
			t_c => t_c,
			o => o(j),
			t_o => tmp(j)
		);
	end generate gen_reg;
	
	tmp(6) <= t_i;
	t_o <= tmp(0);

end LoopIndex_arch;