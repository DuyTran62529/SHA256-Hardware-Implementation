library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity SHA256_data is
port(i: in std_logic_vector (0 to 511);
	o0, o1, o2, o3, o4, o5, o6, o7: out std_logic_vector(0 to 31);

	clk, t_c, t_i: in std_logic;
	t_o: out std_logic;

	loadw_0_15: in std_logic;
	loadw_16_63: in std_logic;
	loadatoh: in std_logic;
	loadh: in std_logic;

	mux_dmux_c: in std_logic_vector (0 to 5);
	mux_atoh_c: in std_logic;
	mux_h_c: in std_logic 
);
end SHA256_data;  

--------------------------------------------------

architecture SHA256_data_arch of SHA256_data is

component atoh_reg
port(h0, h1, h2, h3, h4, h5, h6, h7: in std_logic_vector (0 to 31);
	clk, muxc, load, t_c, t_i: in std_logic; 
	temp1, temp2: in std_logic_vector (0 to 31);
	a, b, c, d, e, f, g, h: out std_logic_vector (0 to 31);
	main_a, main_e: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end component;

component ch
port(e, f, g: std_logic_vector(0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

component maj
port(a, b, c: std_logic_vector(0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

component h_reg
port(a, b, c, d, e, f, g, h: in std_logic_vector (0 to 31);
	clk, muxc, load, t_c, t_i: in std_logic; 
	o0, o1, o2, o3, o4, o5, o6, o7: out std_logic_vector (0 to 31);
	ma, mb, mc, md, me, mf, mg, mh: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end component;

component MainCirc1
port(i: in std_logic_vector (0 to 511);
	clk: in std_logic;
	t_c, t_i: in std_logic;
	t_o: out std_logic;
	mux_2: out std_logic_vector(0 to 31);

	mux_dmux_c: in std_logic_vector(0 to 5);
	loadwreg: in std_logic;
	loadreg_16_63: in std_logic
);
end component;

component MainCirc2
port(a, e, h, ch, maj: in std_logic_vector (0 to 31);
	mux_2: in std_logic_vector(0 to 31);
	kmux_c: in std_logic_vector(0 to 5);

	temp1, temp2: out std_logic_vector(0 to 31)
);
end component;

constant bl: integer := 32;

signal a_o, b_o, c_o, d_o, e_o, f_o, g_o, h_o: std_logic_vector (0 to 31);
signal main_a_o, main_e_o: std_logic_vector (0 to 31);
signal ma_i, mb_i, mc_i, md_i, me_i, mf_i, mg_i, mh_i: std_logic_vector (0 to 31);
signal ch_o, maj_o: std_logic_vector (0 to 31);
signal mux_2_o: std_logic_vector(0 to 31);
signal temp1_o, temp2_o: std_logic_vector(0 to 31);
signal shiftsig: std_logic_vector(0 to 1);


begin
	u0: h_reg
	port map(
		a => a_o, b => b_o, c => c_o, d => d_o, e => e_o, f => f_o, g => g_o, h => h_o,
		clk => clk,
		muxc => mux_h_c,
		load => loadh,
		t_c => t_c,
		t_i => t_i, 
		o0 => o0, o1 => o1, o2 => o2, o3 => o3, o4 => o4, o5 => o5, o6 => o6, o7 => o7,
		ma => ma_i, mb => mb_i, mc => mc_i, md => md_i, me => me_i, mf => mf_i, mg => mg_i, mh => mh_i,
		t_o => shiftsig(0)
	);

	u1: atoh_reg
	port map(
		h0 => ma_i, h1 => mb_i, h2 => mc_i, h3 => md_i, h4 => me_i, h5 => mf_i, h6 => mg_i, h7 => mh_i,
		clk => clk,
		muxc => mux_atoh_c,
		load => loadatoh, 
		t_c => t_c,
		t_i => shiftsig(0), 
		temp1 => temp1_o, temp2 => temp2_o,
		a => a_o, b => b_o, c => c_o, d => d_o, e => e_o, f => f_o, g => g_o, h => h_o,
		main_a => main_a_o, main_e => main_e_o,
		t_o => shiftsig(1)
	);

	uch: ch
	port map(
		e => e_o, f => f_o, g => g_o,
		o => ch_o
	);

	umaj: maj
	port map(
		a => a_o, b => b_o, c => c_o,
		o => maj_o
	);

	u2: MainCirc1
	port map(
		i => i,
		clk => clk,
		t_c => t_c,
		t_i => shiftsig(1),
		t_o => t_o,
		mux_2 => mux_2_o,
		mux_dmux_c => mux_dmux_c,
		loadwreg => loadw_0_15,
		loadreg_16_63 => loadw_16_63
	);

	u3: MainCirc2
	port map(
		a => main_a_o, e => main_e_o, h => h_o,
		ch => ch_o, maj => maj_o,
		mux_2 => mux_2_o,
		kmux_c => mux_dmux_c,
		temp1 => temp1_o, temp2 => temp2_o
	);

end SHA256_data_arch;