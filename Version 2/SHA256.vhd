library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity SHA256 is
port(i: in std_logic_vector (0 to 511);
	o0, o1, o2, o3, o4, o5, o6, o7: out std_logic_vector(0 to 31);
	start, rst, initial: in std_logic;
	clk: in std_logic;
	ready: out std_logic;

	t_c, t_i: in std_logic;
	t_o: out std_logic
);
end SHA256;  

--------------------------------------------------

architecture SHA256_arch of SHA256 is

component SHA256_control
port(start, rst, initial: in std_logic;
	clk: in std_logic;
	mux_h_c: out std_logic;
	loadh: out std_logic;
	load16reg: out std_logic;
	mux_atoh_c: out std_logic;
	loadatoh: out std_logic;
	mux_dmux_c: out std_logic_vector (0 to 5);
	load_16_63: out std_logic;
	ready: out std_logic;

	t_c, t_i: in std_logic;
	t_o: out std_logic
);
end component;

component SHA256_data
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
end component;

signal mux_h_c_s, loadh_s, load16reg_s, mux_atoh_c_s, loadatoh_s, load_16_63_s: std_logic;
signal mux_dmux_c_s: std_logic_vector (0 to 5);
signal shiftsig: std_logic;


begin
	u0: SHA256_control
	port map(
		start => start, rst => rst, initial => initial,
		clk => clk,
		mux_h_c => mux_h_c_s,
		loadh => loadh_s,
		load16reg => load16reg_s,
		mux_atoh_c => mux_atoh_c_s,
		loadatoh => loadatoh_s,
		mux_dmux_c => mux_dmux_c_s,
		load_16_63 => load_16_63_s,
		ready => ready,

		t_c => t_c, t_i => t_i,
		t_o => shiftsig
	);

	u1: SHA256_data
	port map(
		i => i,
		o0 => o0, o1 => o1, o2 => o2, o3 => o3, o4 => o4, o5 => o5, o6 => o6, o7 => o7,
		clk => clk, t_c => t_c, t_i => shiftsig,
		t_o => t_o,
		loadw_0_15 => load16reg_s,
		loadw_16_63 => load_16_63_s,
		loadatoh => loadatoh_s,
		loadh => loadh_s,
		mux_dmux_c => mux_dmux_c_s,
		mux_atoh_c => mux_atoh_c_s,
		mux_h_c => mux_h_c_s 
	);

end SHA256_arch;