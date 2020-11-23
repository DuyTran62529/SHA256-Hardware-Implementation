library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------
--------------------------------------------------

entity Sha256_data is
port(i: in std_logic_vector (0 to 511);
	clk: in std_logic;
	mux_h_c, mux_atoh_c: in std_logic;
	mux_123_c: in std_logic_vector (0 to 5);
	mux_4_c: in std_logic;
	mux_5_c: in std_logic_vector (0 to 5);
	mux_6_c: in std_logic;
	mux_7_c: in std_logic_vector (0 to 5);
	mux_8_c: in std_logic;
	mux_9_c: in std_logic_vector (0 to 5);
	rc1_1, rc2_1, sen_1, sc_1: in std_logic;
	rc1_2, rc2_2, sen_2, sc_2: in std_logic;
	rc1_3, rc2_3, sen_3, sc_3: in std_logic;
	load16reg: in std_logic;
	loadatoh: in std_logic;
	loadh: in std_logic;
	load48reg: in std_logic;
	dmux_load48reg_c: in std_logic_vector (0 to 5);
	loadrg1, loadrg2, loadrg3: in std_logic;
	loads0, loads1: in std_logic;
	loadtemp1, loadtemp2: in std_logic;
	t_c, t_i: in std_logic;
	o0, o1, o2, o3, o4, o5, o6, o7: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end Sha256_data;  

--------------------------------------------------

architecture Sha256_data_arch of Sha256_data is

component MainCir1
port(i: in std_logic_vector (0 to 2015);
	clk: in std_logic;
	mux_123: in std_logic_vector (0 to 5);
	rc1_1, rc2_1, sen_1, sc_1: in std_logic;
	rc1_2, rc2_2, sen_2, sc_2: in std_logic;
	rc1_3, rc2_3, sen_3, sc_3: in std_logic;
	loadrg1, loadrg2, loadrg3: in std_logic;
	loads0, loads1: in std_logic;
	t_c, t_i: in std_logic;
	s0, s1: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end component;

component MainCir2
port(s0, h, s1, ch, maj: in std_logic_vector (0 to 31);
	mux5_in: in std_logic_vector (0 to 1535);
	mux7_in, mux9_in: in std_logic_vector (0 to 2047);
	mux4_c, mux6_c, mux8_c: in std_logic;
	mux5_c: in std_logic_vector (0 to 5);
	mux7_c, mux9_c: in std_logic_vector (0 to 5);
	clk: in std_logic;
	temp1_load, temp2_load: in std_logic;
	t_c, t_i: in std_logic;
	temp1, temp2, reg_o: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end component;

component w_reg
port(i_0_15: in std_logic_vector (0 to 511);
	i_16_63: in std_logic_vector (0 to 31);
	clk, load16, load48, t_c, t_i: in std_logic;
	load48dmux: in std_logic_vector(0 to 5); 
	o: out std_logic_vector (0 to 2047);
	t_o: out std_logic
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

component atoh_reg
port(h0, h1, h2, h3, h4, h5, h6, h7: in std_logic_vector (0 to 31);
	clk, muxc, load, t_c, t_i: in std_logic; 
	temp1, temp2: in std_logic_vector (0 to 31);
	a, b, c, d, e, f, g, h: out std_logic_vector (0 to 31);
	main_a, main_e: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end component;

component k_reg
port(k_out: out std_logic_vector (0 to 2047)
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

signal mux_123_in: std_logic_vector (0 to 2015);
signal s0_in, s1_in, ch_in, maj_in: std_logic_vector (0 to 31);
signal mux_5_in: std_logic_vector (0 to 1535);
signal mux_7_in, mux_9_in: std_logic_vector (0 to 2047);
signal i_16_63_in: std_logic_vector (0 to 31);
signal a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in: std_logic_vector (0 to 31);
signal h0_in, h1_in, h2_in, h3_in, h4_in, h5_in, h6_in, h7_in: std_logic_vector (0 to 31);
signal temp1_in, temp2_in: std_logic_vector (0 to 31);
signal shift_signal: std_logic_vector (0 to 3);

begin
	--atoh_reg and h_reg connections--
	u0: h_reg
	port map(
		a => a_in,
		b => b_in,
		c => c_in,
		d => d_in,
		e => e_in,
		f => f_in,
		g => g_in,
		h => h_in,
		clk => clk,
		muxc => mux_h_c,
		load => loadh,
		t_c => t_c,
		t_i => t_i, 
		o0 => o0,------------------------
		o1 => o1,------------------------
		o2 => o2,------------------------
		o3 => o3,-----Hash digests-------
		o4 => o4,------------------------
		o5 => o5,------------------------
		o6 => o6,------------------------
		o7 => o7,------------------------
		ma => h0_in,
		mb => h1_in,
		mc => h2_in,
		md => h3_in,
		me => h4_in,
		mf => h5_in,
		mg => h6_in,
		mh => h7_in,
		t_o => shift_signal(0)
	);

	u1: atoh_reg
	port map(
		h0 => h0_in,
		h1 => h1_in,
		h2 => h2_in,
		h3 => h3_in,
		h4 => h4_in,
		h5 => h5_in,
		h6 => h6_in,
		h7 => h7_in,
		clk => clk,
		muxc => mux_atoh_c,
		load => loadatoh,
		t_c => t_c,
		t_i => shift_signal(0),
		temp1 => temp1_in,
		temp2 => temp2_in,
		a => a_in,
		b => b_in,
		c => c_in,
		d => d_in,
		e => e_in,
		f => f_in,
		g => g_in,
		h => h_in,
		main_a => mux_123_in (61*32 to (61*32 + 31)),
		main_e => mux_123_in (62*32 to (62*32 + 31)),
		t_o => shift_signal(1)
	);

	--w reg--
	u2: w_reg
	port map(
		i_0_15 => i,
		i_16_63 => i_16_63_in,
		clk => clk,
		load16 => load16reg,
		load48 => load48reg,
		t_c => t_c,
		t_i => shift_signal(1),
		load48dmux => dmux_load48reg_c, 
		o => mux_7_in,
		t_o => shift_signal(2)
	);

	--ch--
	u3: ch
	port map(
		e => e_in,
		f => f_in,
		g => g_in,
		o => ch_in
	);

	--maj--
	u4: maj
	port map(
		a => a_in,
		b => b_in,
		c => c_in,
		o => maj_in
	);

	--k_reg--
	u5: k_reg
	port map(
		k_out => mux_9_in
	);

	--MainCirc connections--
	mux_123_in (0*32 to (60*32 + 31)) <= mux_7_in (1*32 to (61*32 + 31));

	u6: MainCir1
	port map(
		i => mux_123_in,
		clk => clk,
		mux_123 => mux_123_c,
		rc1_1 => rc1_1,
		rc2_1 => rc2_1,
		sen_1 => sen_1,
		sc_1 => sc_1,
		rc1_2 => rc1_2,
		rc2_2 => rc2_2,
		sen_2 => sen_2,
		sc_2 => sc_2,
		rc1_3 => rc1_3,
		rc2_3 => rc2_3,
		sen_3 => sen_3,
		sc_3 => sc_3,
		loadrg1 => loadrg1,
		loadrg2 => loadrg2,
		loadrg3 => loadrg3,
		loads0 => loads0,
		loads1 => loads1,
		t_c => t_c,
		t_i => shift_signal(2),
		s0 => s0_in,
		s1 => s1_in,
		t_o => shift_signal(3)
	);

	mux_5_in <= mux_7_in (0*32 to (47*32 + 31));

	u7: MainCir2
	port map(
		s0 => s0_in,
		h => h_in,
		s1 => s1_in,
		ch => ch_in,
		maj => maj_in,
		mux5_in => mux_5_in,
		mux7_in => mux_7_in, 
		mux9_in => mux_9_in,
		mux4_c => mux_4_c,
		mux6_c => mux_6_c,
		mux8_c => mux_8_c,
		mux5_c => mux_5_c,
		mux7_c => mux_7_c,
		mux9_c => mux_9_c,
		clk => clk,
		temp1_load => loadtemp1,
		temp2_load => loadtemp2,
		t_c => t_c,
		t_i => shift_signal(3),
		temp1 => temp1_in, 
		temp2 => temp2_in,
		reg_o => i_16_63_in,
		t_o => t_o
	);	

end Sha256_data_arch;