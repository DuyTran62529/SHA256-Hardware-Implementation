library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity LoopCounter is
port(incre, t_c, t_i, clk, load_16: in std_logic;
	t_o: out std_logic;
	o: out std_logic_vector (0 to 5)
);
end LoopCounter;  

--------------------------------------------------

architecture LoopCounter_arch of LoopCounter is

component LoopIndex 
port(i: in std_logic_vector (0 to 5);
	load, t_c, t_i, clk: in std_logic;
	t_o: out std_logic;
	o: out std_logic_vector (0 to 5)
);
end component;

component OR2x1
port(x, y: in std_logic;
	o: out std_logic
);
end component;

component MUX2x1
port(a, b: in std_logic;
	c: in std_logic;
	o: out std_logic
);
end component;

component FullAdd
port(a, b, cin: in std_logic;
	cout: out std_logic;
	o: out std_logic
);
end component;

signal loop_load: std_logic;
signal tmp_o, add_o, mux_o: std_logic_vector (0 to 5);
signal step1: std_logic_vector (0 to 5);
signal step16: std_logic_vector (0 to 5);
signal carry: std_logic_vector (0 to 6);

begin
	step1 <= "000001";
	step16 <= "010000";

	u0: OR2x1
	port map
	(
		x => load_16,
		y => incre,
		o => loop_load
	);

	u1: LoopIndex
	port map
	(
		i => add_o,
		load => loop_load, 
		t_c => t_c, 
		t_i => t_i, 
		clk => clk,
		t_o => t_o,
		o => tmp_o
	);

	o <= tmp_o;

	gen_mux: for j in 0 to 5 generate
		umux: MUX2x1
		port map(
			a => step1(j),
			b => step16(j),
			c => load_16,
			o => mux_o(j)
		);
	end generate gen_mux;

	gen_add: for t in 0 to 5 generate
		uadd: FullAdd
		port map(
			a => tmp_o(t),
			b => mux_o(t),
			cin => carry(t + 1),
			cout => carry(t),
			o => add_o(t)
		);
	end generate gen_add;

	carry(6) <= '0';

end LoopCounter_arch;