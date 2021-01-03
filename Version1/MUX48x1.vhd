library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------
--Control signals MSB to LSB: c6 c5 c4 c3 c2 c1---
--------------------------------------------------

entity MUX48x1 is
port(i: in std_logic_vector(0 to 47);
	c1, c2, c3, c4, c5, c6: in std_logic;
	o: out std_logic
);
end MUX48x1;  

--------------------------------------------------

architecture MUX48x1_arch of MUX48x1 is

component MUX8x1
port(i: in std_logic_vector(0 to 7);
	c1, c2, c3: in std_logic;
	o: out std_logic
);
end component;

component MUX2x1 is
port(a, b: in std_logic;
	c: in std_logic;
	o: out std_logic
);
end component;

component MUX4x1 is
port(a, b, c, d: in std_logic;
	c1, c2: in std_logic;
	o: out std_logic
);
end component;

signal muxo_1: std_logic_vector(0 to 5);
signal muxo_2_4, muxo_2_2: std_logic;

begin
	--Layer 1 muxes
	gen_mux: for j in 0 to 5 generate
		ux: MUX8x1
		port map(
			i => i((j*8)  to (j*8+7)),
			c1 => c1,
			c2 => c2,
			c3 => c3,
			o => muxo_1(j)
		);
	end generate gen_mux;

	--Layer 2 muxes
	u0: MUX4x1
	port map(
		a => muxo_1(0),
		b => muxo_1(1),
		c => muxo_1(2),
		d => muxo_1(3),
		c1 => c4,
		c2 => c5,
		o => muxo_2_4
	);

	u1: MUX2x1
	port map(
		a => muxo_1(4),
		b => muxo_1(5),
		c => c4,
		o => muxo_2_2
	);	

	--Layer 3 muxes
	u2: MUX2x1
	port map(
		a => muxo_2_4,
		b => muxo_2_2,
		c => c6,
		o => o
	);

end MUX48x1_arch;