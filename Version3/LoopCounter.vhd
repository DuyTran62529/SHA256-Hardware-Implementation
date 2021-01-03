library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity LoopCounter is
port(incre, t_c, t_i, clk: in std_logic;
	t_o: out std_logic;
	o: out std_logic_vector (0 to 5)
);
end LoopCounter;  

--------------------------------------------------

architecture LoopCounter_arch of LoopCounter is

component FF_reg
port(i, t_i, clk, t_c: in std_logic;
	o, t_o: out std_logic
);
end component;

component MUX2x1
port(a, b: in std_logic;
	c: in std_logic;
	o: out std_logic
);
end component;

component XOR2x1
port(x, y: in std_logic;
	o: out std_logic
);
end component;

component AND2x1
port(x, y: in std_logic;
	o: out std_logic
);
end component;

component NOT1x1
port(x: in std_logic;
	o: out std_logic
);
end component;

signal clk_inc_mux_o: std_logic;
signal reg_o: std_logic_vector (0 to 5);
signal not_o: std_logic;
signal xor_i2: std_logic_vector (0 to 4);
signal xor_o: std_logic_vector (0 to 4);
signal and_i2: std_logic_vector (0 to 4);
signal shift_sig: std_logic_vector (0 to 4);

begin
	u0: MUX2x1
	port map
	(
		a => incre,
		b => clk,
		c => t_c,
		o => clk_inc_mux_o
	);

	--LSB reg
	u1: FF_reg
	port map
	(
		i => not_o,
		t_i => t_i,
		clk => clk_inc_mux_o,
		t_c => t_c,
		o => reg_o(0),
		t_o => shift_sig(0)
	);

	u2: NOT1x1
	port map
	(
		x => reg_o(0),
		o => not_o
	);

	o(5) <= reg_o(0);
	and_i2(0) <= reg_o(0);
	xor_i2(0) <= reg_o(0);

	gen_reg: for t in 0 to 3 generate
		ureg: FF_reg
		port map(
			i => xor_o(t),
			t_i => shift_sig(t),
			clk => clk_inc_mux_o,
			t_c => t_c,
			o => reg_o(t + 1),
			t_o => shift_sig(t + 1)
		);

		uxor: XOR2x1
		port map(
			x => reg_o(t + 1),
			y => xor_i2(t),
			o => xor_o(t)
		);

		uand: AND2x1
		port map(
			x => reg_o(t + 1),
			y => and_i2(t),
			o => and_i2(t + 1)
		);

		o(5 - t - 1) <= reg_o(t + 1);
		xor_i2(t + 1) <= and_i2(t + 1);
	end generate gen_reg;

	u3: FF_reg
	port map(
		i => xor_o(4),
		t_i => shift_sig(4),
		clk => clk_inc_mux_o,
		t_c => t_c,
		o => reg_o(5),
		t_o => t_o
	);

	u4: XOR2x1
	port map(
			x => reg_o(5),
			y => xor_i2(4),
			o => xor_o(4)
	);
	o(0) <= reg_o(5);
end LoopCounter_arch;