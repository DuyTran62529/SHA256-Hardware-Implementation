library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity SHA256_control is
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
end SHA256_control;  

--------------------------------------------------

architecture SHA256_control_arch of SHA256_control is

component State_m0
port(start, rst, initial, loop_comp_47, loop_comp_63: in std_logic;
	clk: in std_logic;
	mux_h_c: out std_logic;
	loadh: out std_logic;
	load16reg: out std_logic;
	mux_atoh_c: out std_logic;
	loadatoh: out std_logic;
	load_16_63: out std_logic;
	loop_incre: out std_logic;
	ready: out std_logic
);
end component;

component LoopControl
port(incre, t_c, t_i, clk: in std_logic;
	t_o, equal63, equal47: out std_logic;
	o: out std_logic_vector (0 to 5)
);
end component;

signal equal63_o, equal47_o: std_logic;
signal loop_incre_o: std_logic;


begin
	u0: State_m0
	port map(
		start => start, rst => rst, initial => initial, loop_comp_47 => equal47_o, loop_comp_63 => equal63_o,
		clk => clk,
		mux_h_c => mux_h_c,
		loadh => loadh, 
		load16reg => load16reg,
		mux_atoh_c => mux_atoh_c,
		loadatoh => loadatoh,
		load_16_63 => load_16_63,
		loop_incre => loop_incre_o,
		ready => ready
	);

	u1: LoopControl
	port map(
		incre => loop_incre_o,
		t_c => t_c,
		t_i => t_i,
		clk => clk,
		t_o => t_o,
		equal63 => equal63_o,
		equal47 => equal47_o,
		o => mux_dmux_c
	);

end SHA256_control_arch;