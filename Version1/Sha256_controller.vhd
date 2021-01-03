library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity Sha256_controller is
port(start, rst, initial: in std_logic;
	clk: in std_logic;
	t_c, t_i: in std_logic;
	mux_h_c, mux_atoh_c: out std_logic;
	mux_123_c: out std_logic_vector (0 to 5);
	mux_4_c: out std_logic;
	mux_5_c: out std_logic_vector (0 to 5);
	mux_6_c: out std_logic;
	mux_7_c: out std_logic_vector (0 to 5);
	mux_8_c: out std_logic;
	mux_9_c: out std_logic_vector (0 to 5);
	rc1_1, rc2_1, sen_1, sc_1: out std_logic;
	rc1_2, rc2_2, sen_2, sc_2: out std_logic;
	rc1_3, rc2_3, sen_3, sc_3: out std_logic;
	load16reg: out std_logic;
	loadatoh: out std_logic;
	loadh: out std_logic;
	load48reg: out std_logic;
	dmux_load48reg_c: out std_logic_vector (0 to 5);
	loadrg1, loadrg2, loadrg3: out std_logic;
	loads0, loads1: out std_logic;
	loadtemp1, loadtemp2: out std_logic;
	ready, t_o: out std_logic
);
end Sha256_controller;  

--------------------------------------------------

architecture Sha256_controller_arch of Sha256_controller is

component State_m0
port(start, rst, initial, loop_comp, sm1_done, sm2_done: in std_logic;
	clk: in std_logic;
	mux_h_c: out std_logic;
	loadh: out std_logic;
	load16reg: out std_logic;
	mux_atoh_c: out std_logic;
	loadatoh: out std_logic;
	sm1, sm2: out std_logic;
	counter_load_16: out std_logic;
	loop_incre: out std_logic;
	ready: out std_logic
);
end component;

component State_m1
port(sm1: in std_logic;
	clk: in std_logic;
	mux_123_c_offset: out std_logic_vector (0 to 5);
	mux_123_c_offset_c: out std_logic;
	rc1_1, rc2_1, sen_1, sc_1: out std_logic;
	rc1_2, rc2_2, sen_2, sc_2: out std_logic;
	rc1_3, rc2_3, sen_3, sc_3: out std_logic;
	loadrg1, loadrg2, loadrg3: out std_logic;
	loads0, loads1: out std_logic;
	load48reg: out std_logic;
	done: out std_logic
);
end component;

component State_m2
port(sm2: in std_logic;
	clk: in std_logic;
	mux_123_c_mask_1: out std_logic;
	mux_123_c_mask_0: out std_logic;
	rc1_1, rc2_1, sen_1, sc_1: out std_logic;
	rc1_2, rc2_2, sen_2, sc_2: out std_logic;
	rc1_3, rc2_3, sen_3, sc_3: out std_logic;
	loadrg1, loadrg2, loadrg3: out std_logic;
	loads0, loads1: out std_logic;
	mux_4_c, mux_6_c, mux_8_c: out std_logic;
	loadtemp1, loadtemp2: out std_logic;
	done: out std_logic
);
end component;

component LoopControl
port(incre, t_c, t_i, clk, load_16: in std_logic;
	t_o, equal63: out std_logic;
	o: out std_logic_vector (0 to 5)
);
end component;

component sm1sm2_overlapped_signals
port(sm1_rc1_1, sm1_rc2_1, sm1_sen_1, sm1_sc_1: in std_logic;
	sm1_rc1_2, sm1_rc2_2, sm1_sen_2, sm1_sc_2: in std_logic;
	sm1_rc1_3, sm1_rc2_3, sm1_sen_3, sm1_sc_3: in std_logic;
	sm1_loadrg1, sm1_loadrg2, sm1_loadrg3: in std_logic;
	sm1_loads0, sm1_loads1: in std_logic;

	sm2_rc1_1, sm2_rc2_1, sm2_sen_1, sm2_sc_1: in std_logic;
	sm2_rc1_2, sm2_rc2_2, sm2_sen_2, sm2_sc_2: in std_logic;
	sm2_rc1_3, sm2_rc2_3, sm2_sen_3, sm2_sc_3: in std_logic;
	sm2_loadrg1, sm2_loadrg2, sm2_loadrg3: in std_logic;
	sm2_loads0, sm2_loads1: in std_logic;
	sm2_mux_4_c, sm2_mux_6_c: in std_logic;

	sm: in std_logic;

	rc1_1, rc2_1, sen_1, sc_1: out std_logic;
	rc1_2, rc2_2, sen_2, sc_2: out std_logic;
	rc1_3, rc2_3, sen_3, sc_3: out std_logic;
	loadrg1, loadrg2, loadrg3: out std_logic;
	loads0, loads1: out std_logic;
	mux_4_c, mux_6_c: out std_logic
);
end component;

component Mux_123_control
port(i: in std_logic_vector (0 to 5);
	mux_123_c_offset: in std_logic_vector (0 to 5);
	mux_123_c_offset_c: in std_logic;
	sm, mask1, mask0: in std_logic;
	o: out std_logic_vector (0 to 5)
);
end component;

component Mux_5_control
port(i: in std_logic_vector (0 to 5);
	o: out std_logic_vector (0 to 5)
);
end component;

component Mux_7_control
port(i: in std_logic_vector (0 to 5);
	sm: in std_logic;
	o: out std_logic_vector (0 to 5)
);
end component;

signal LoopControl_o: std_logic_vector (0 to 5);
signal incre_in, loop_comp_in, load_16_in: std_logic;

signal mux_123_c_offset_in: std_logic_vector (0 to 5);
signal mux_123_c_offset_c_in: std_logic;
signal mask1_in, mask0_in: std_logic;
signal sm2_in: std_logic;

signal sm1_rc1_1_in, sm1_rc2_1_in, sm1_sen_1_in, sm1_sc_1_in: std_logic;
signal sm1_rc1_2_in, sm1_rc2_2_in, sm1_sen_2_in, sm1_sc_2_in: std_logic;
signal sm1_rc1_3_in, sm1_rc2_3_in, sm1_sen_3_in, sm1_sc_3_in: std_logic;
signal sm1_loadrg1_in, sm1_loadrg2_in, sm1_loadrg3_in: std_logic;
signal sm1_loads0_in, sm1_loads1_in: std_logic;

signal sm2_rc1_1_in, sm2_rc2_1_in, sm2_sen_1_in, sm2_sc_1_in: std_logic;
signal sm2_rc1_2_in, sm2_rc2_2_in, sm2_sen_2_in, sm2_sc_2_in: std_logic;
signal sm2_rc1_3_in, sm2_rc2_3_in, sm2_sen_3_in, sm2_sc_3_in: std_logic;
signal sm2_loadrg1_in, sm2_loadrg2_in, sm2_loadrg3_in: std_logic;
signal sm2_loads0_in, sm2_loads1_in: std_logic;
signal sm2_mux_4_c_in, sm2_mux_6_c_in: std_logic;

signal sm1_in: std_logic;

signal sm1_done_in, sm2_done_in: std_logic;

begin
	u0: LoopControl
	port map(
		incre => incre_in, 
		t_c => t_c,
		t_i => t_i,
		clk => clk,
		load_16 => load_16_in,
		t_o => t_o,
		equal63 => loop_comp_in,
		o => LoopControl_o
	);

	u1: Mux_123_control
	port map(
		i => LoopControl_o,
		mux_123_c_offset => mux_123_c_offset_in,
		mux_123_c_offset_c => mux_123_c_offset_c_in,
		sm => sm2_in, 
		mask1 => mask1_in,
		mask0 => mask0_in,
		o => mux_123_c
	);

	u2: Mux_5_control
	port map(
		i => LoopControl_o,
		o => mux_5_c
	);

	u3: Mux_7_control
	port map(
		i => LoopControl_o,
		sm => sm2_in,
		o => mux_7_c
	);

	mux_9_c <= LoopControl_o;
	dmux_load48reg_c <= LoopControl_o;

	u4: sm1sm2_overlapped_signals
	port map(
		sm1_rc1_1 => sm1_rc1_1_in, sm1_rc2_1 => sm1_rc2_1_in, sm1_sen_1 => sm1_sen_1_in, sm1_sc_1 => sm1_sc_1_in,
		sm1_rc1_2 => sm1_rc1_2_in, sm1_rc2_2 => sm1_rc2_2_in, sm1_sen_2 => sm1_sen_2_in, sm1_sc_2 => sm1_sc_2_in,
		sm1_rc1_3 => sm1_rc1_3_in, sm1_rc2_3 => sm1_rc2_3_in, sm1_sen_3 => sm1_sen_3_in, sm1_sc_3 => sm1_sc_3_in,
		sm1_loadrg1 => sm1_loadrg1_in, sm1_loadrg2 => sm1_loadrg2_in, sm1_loadrg3 => sm1_loadrg3_in,
		sm1_loads0 => sm1_loads0_in, sm1_loads1 => sm1_loads1_in,

		sm2_rc1_1 => sm2_rc1_1_in, sm2_rc2_1 => sm2_rc2_1_in, sm2_sen_1 => sm2_sen_1_in, sm2_sc_1 => sm2_sc_1_in,
		sm2_rc1_2 => sm2_rc1_2_in, sm2_rc2_2 => sm2_rc2_2_in, sm2_sen_2 => sm2_sen_2_in, sm2_sc_2 => sm2_sc_2_in,
		sm2_rc1_3 => sm2_rc1_3_in, sm2_rc2_3 => sm2_rc2_3_in, sm2_sen_3 => sm2_sen_3_in, sm2_sc_3 => sm2_sc_3_in,
		sm2_loadrg1 => sm2_loadrg1_in, sm2_loadrg2 => sm2_loadrg2_in, sm2_loadrg3 => sm2_loadrg3_in,
		sm2_loads0 => sm2_loads0_in, sm2_loads1 => sm2_loads1_in,
		sm2_mux_4_c => sm2_mux_4_c_in, sm2_mux_6_c => sm2_mux_6_c_in,

		sm => sm2_in,

		rc1_1 => rc1_1, rc2_1 => rc2_1, sen_1 => sen_1, sc_1 => sc_1,
		rc1_2 => rc1_2, rc2_2 => rc2_2, sen_2 => sen_2, sc_2 => sc_2,
		rc1_3 => rc1_3, rc2_3 => rc2_3, sen_3 => sen_3, sc_3 => sc_3,
		loadrg1 => loadrg1, loadrg2 => loadrg2, loadrg3 => loadrg3,
		loads0 => loads0, loads1 => loads1,
		mux_4_c => mux_4_c,
		mux_6_c => mux_6_c
	);

	u5: State_m0
	port map(
		start => start,
		rst => rst,
		initial => initial,
		loop_comp => loop_comp_in,
		sm1_done => sm1_done_in,
		sm2_done => sm2_done_in,
		clk => clk,
		mux_h_c => mux_h_c,
		loadh => loadh,
		load16reg => load16reg,
		mux_atoh_c => mux_atoh_c,
		loadatoh => loadatoh,
		sm1 => sm1_in,
		sm2 => sm2_in,
		counter_load_16 => load_16_in,
		loop_incre => incre_in,
		ready => ready
	);

	u6: State_m1
	port map(
		sm1 => sm1_in,
		clk => clk,
		mux_123_c_offset => mux_123_c_offset_in,
		mux_123_c_offset_c => mux_123_c_offset_c_in,

		rc1_1 => sm1_rc1_1_in,
		rc2_1 => sm1_rc2_1_in,
		sen_1 => sm1_sen_1_in,
		sc_1 => sm1_sc_1_in,

		rc1_2 => sm1_rc1_2_in,
		rc2_2 => sm1_rc2_2_in,
		sen_2 => sm1_sen_2_in,
		sc_2 => sm1_sc_2_in,
		
		rc1_3 => sm1_rc1_3_in,
		rc2_3 => sm1_rc2_3_in,
		sen_3 => sm1_sen_3_in,
		sc_3 => sm1_sc_3_in,
		
		loadrg1 => sm1_loadrg1_in,
		loadrg2 => sm1_loadrg2_in,
		loadrg3 => sm1_loadrg3_in,
		loads0 => sm1_loads0_in,
		loads1 => sm1_loads1_in,
		load48reg => load48reg,
		done => sm1_done_in
	);

	u7: State_m2
	port map(
		sm2 => sm2_in,
		clk => clk,
		mux_123_c_mask_1 => mask1_in,
		mux_123_c_mask_0 => mask0_in,

		rc1_1 => sm2_rc1_1_in,
		rc2_1 => sm2_rc2_1_in,
		sen_1 => sm2_sen_1_in,
		sc_1 => sm2_sc_1_in,

		rc1_2 => sm2_rc1_2_in,
		rc2_2 => sm2_rc2_2_in,
		sen_2 => sm2_sen_2_in,
		sc_2 => sm2_sc_2_in,
		
		rc1_3 => sm2_rc1_3_in,
		rc2_3 => sm2_rc2_3_in,
		sen_3 => sm2_sen_3_in,
		sc_3 => sm2_sc_3_in,
		
		loadrg1 => sm2_loadrg1_in,
		loadrg2 => sm2_loadrg2_in,
		loadrg3 => sm2_loadrg3_in,
		loads0 => sm2_loads0_in,
		loads1 => sm2_loads1_in,

		mux_4_c => sm2_mux_4_c_in,
		mux_6_c => sm2_mux_6_c_in,
		mux_8_c => mux_8_c,
		loadtemp1 => loadtemp1,
		loadtemp2 => loadtemp2,
		done => sm2_done_in
	);
	
end Sha256_controller_arch;