library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity h_reg is
port(a, b, c, d, e, f, g, h: in std_logic_vector (0 to 31);
	clk, muxc, load, t_c, t_i: in std_logic; 
	o0, o1, o2, o3, o4, o5, o6, o7: out std_logic_vector (0 to 31);
	ma, mb, mc, md, me, mf, mg, mh: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end h_reg;  

--------------------------------------------------

architecture h_reg_arch of h_reg is

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

constant h_initial: bit32vector := (X"6A09E667", X"BB67AE85", X"3C6EF372", X"A54FF53A", X"510E527F", X"9B05688C", X"1F83D9AB", X"5BE0CD19");
signal mux_o: bit32vector;
signal hreg_o: bit32vector;
signal atoh: bit32vector;
signal add_o: bit32vector;
signal shift_signal: std_logic_vector(0 to 8);

begin
	atoh(0) <= a;
	atoh(1) <= b;
	atoh(2) <= c;
	atoh(3) <= d;
	atoh(4) <= e;
	atoh(5) <= f;
	atoh(6) <= g;
	atoh(7) <= h;

	--8 MUXES--
	gen_mux: for j in 0 to 7 generate
		ux1: MUX2x1_32
		port map(
			a => add_o(j), 
			b => h_initial(j),
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
			o => hreg_o(t),
			t_o => shift_signal(t + 1)
		);
	end generate gen_reg;

	t_o <= shift_signal(8);

	ma <= hreg_o(0);
	mb <= hreg_o(1);
	mc <= hreg_o(2);
	md <= hreg_o(3);
	me <= hreg_o(4);
	mf <= hreg_o(5);
	mg <= hreg_o(6);
	mh <= hreg_o(7);

	o0 <= hreg_o(0);
	o1 <= hreg_o(1);
	o2 <= hreg_o(2);
	o3 <= hreg_o(3);
	o4 <= hreg_o(4);
	o5 <= hreg_o(5);
	o6 <= hreg_o(6);
	o7 <= hreg_o(7);

	--8 Adders--
	gen_add: for z in 0 to 7 generate
	ux3: Add32
	port map(
		a => hreg_o(z), 
		b => atoh(z),
		o => add_o(z)
	);
	end generate gen_add;

end h_reg_arch;