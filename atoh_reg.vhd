library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity atoh_reg is
port(h0, h1, h2, h3, h4, h5, h6, h7: in std_logic_vector (0 to 31);
	clk, muxc, load, t_c, t_i: in std_logic; 
	temp1, temp2: in std_logic_vector (0 to 31);
	a, b, c, d, e, f, g, h: out std_logic_vector (0 to 31);
	main_a, main_e: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end atoh_reg;  

--------------------------------------------------

architecture atoh_reg_arch of atoh_reg is

component BitReg_32
port(i: in std_logic_vector (0 to 31);
	clk, load, t_c, t_i: in std_logic;
	o: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end component;

component MUX2x1_32
port(a, b: in std_logic_vector (0 to 31);
	c: in std_logic;
	o: out std_logic_vector (0 to 31)
);
end component;

component Add32
port(a, b: in std_logic_vector(0 to 31);
	o: out std_logic_vector(0 to 31)
);
end component;

type bit32vector is array (0 to 7) of std_logic_vector (0 to 31);

signal mux_i0, mux_i1: bit32vector;
signal mux_o: bit32vector;
signal atohreg_o: bit32vector;
signal adda_o, addb_o: std_logic_vector (0 to 31);
signal shift_signal: std_logic_vector(0 to 8);

begin
	mux_i1(0) <= h0;
	mux_i1(1) <= h1;
	mux_i1(2) <= h2;
	mux_i1(3) <= h3;
	mux_i1(4) <= h4;
	mux_i1(5) <= h5;
	mux_i1(6) <= h6;
	mux_i1(7) <= h7;

	--8 MUXES--
	gen_mux: for j in 0 to 7 generate
		ux1: MUX2x1_32
		port map(
			a => mux_i0(j), 
			b => mux_i1(j),
			c => muxc,
			o => mux_o(j)
		);
	end generate gen_mux;

	--8 h registers--
	shift_signal(0) <= t_i;

	gen_reg: for t in 0 to 7 generate
		ux2: BitReg_32
		port map(
			i => mux_o(t),
			clk => clk,
			load => load,
			t_c => t_c,
			t_i => shift_signal(t),
			o => atohreg_o(t),
			t_o => shift_signal(t + 1)
		);
	end generate gen_reg;

	t_o <= shift_signal(8);

	a <= atohreg_o(0);
	b <= atohreg_o(1);
	c <= atohreg_o(2);
	d <= atohreg_o(3);
	e <= atohreg_o(4);
	f <= atohreg_o(5);
	g <= atohreg_o(6);
	h <= atohreg_o(7);

	main_a <= atohreg_o(0);
	main_e <= atohreg_o(4);

	mux_i0(1) <= atohreg_o(0);
	mux_i0(2) <= atohreg_o(1);
	mux_i0(3) <= atohreg_o(2);
	mux_i0(5) <= atohreg_o(4);
	mux_i0(6) <= atohreg_o(5);
	mux_i0(7) <= atohreg_o(6);

	--Adders A--
	u0: Add32
	port map(
		a => temp1, 
		b => temp2,
		o => mux_i0(0)
	);

	--Adders E--
	u1: Add32
	port map(
		a => atohreg_o(3), 
		b => temp1,
		o => mux_i0(4)
	);

end atoh_reg_arch;