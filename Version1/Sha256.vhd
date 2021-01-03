library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity Sha256 is
port(start, rst, initial: in std_logic;
	i: in std_logic_vector (0 to 511);
	clk: in std_logic;
	t_c, t_i: in std_logic;
	o0, o1, o2, o3, o4, o5, o6, o7: out std_logic_vector (0 to 31);
	ready, t_o: out std_logic
);
end Sha256;  

--------------------------------------------------

architecture Sha256_arch of Sha256 is

component Sha256_controller
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
end component;

component Sha256_data
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
end component;

signal mux_h_c_in, mux_atoh_c_in: std_logic;
signal mux_123_c_in: std_logic_vector (0 to 5);
signal mux_4_c_in: std_logic;
signal mux_5_c_in: std_logic_vector (0 to 5);
signal mux_6_c_in: std_logic;
signal mux_7_c_in: std_logic_vector (0 to 5);
signal mux_8_c_in: std_logic;
signal mux_9_c_in: std_logic_vector (0 to 5);
signal rc1_1_in, rc2_1_in, sen_1_in, sc_1_in: std_logic;
signal rc1_2_in, rc2_2_in, sen_2_in, sc_2_in: std_logic;
signal rc1_3_in, rc2_3_in, sen_3_in, sc_3_in: std_logic;
signal load16reg_in: std_logic;
signal loadatoh_in: std_logic;
signal loadh_in: std_logic;
signal load48reg_in: std_logic;
signal dmux_load48reg_c_in: std_logic_vector (0 to 5);
signal loadrg1_in, loadrg2_in, loadrg3_in: std_logic;
signal loads0_in, loads1_in: std_logic;
signal loadtemp1_in, loadtemp2_in: std_logic;

signal shift_signal: std_logic;

begin
	u0: Sha256_controller
	port map(
		start => start,
		rst => rst,
		initial => initial,
		clk => clk,
		t_c => t_c, 
		t_i => t_i,
		
		mux_h_c => mux_h_c_in, mux_atoh_c => mux_atoh_c_in,
		mux_123_c => mux_123_c_in,
		mux_4_c => mux_4_c_in,
		mux_5_c => mux_5_c_in,
		mux_6_c => mux_6_c_in,
		mux_7_c => mux_7_c_in,
		mux_8_c => mux_8_c_in,
		mux_9_c => mux_9_c_in,
		rc1_1 => rc1_1_in, rc2_1 => rc2_1_in, sen_1 => sen_1_in, sc_1 => sc_1_in,
		rc1_2 => rc1_2_in, rc2_2 => rc2_2_in, sen_2 => sen_2_in, sc_2 => sc_2_in,
		rc1_3 => rc1_3_in, rc2_3 => rc2_3_in, sen_3 => sen_3_in, sc_3 => sc_3_in,
		load16reg => load16reg_in,
		loadatoh => loadatoh_in,
		loadh => loadh_in,
		load48reg => load48reg_in,
		dmux_load48reg_c => dmux_load48reg_c_in,
		loadrg1 => loadrg1_in, loadrg2 => loadrg2_in, loadrg3 => loadrg3_in,
		loads0 => loads0_in, loads1 => loads1_in,
		loadtemp1 => loadtemp1_in, loadtemp2 => loadtemp2_in,
		
		ready => ready, 
		t_o => shift_signal
	);

	u1: Sha256_data
	port map(
		i => i,
		clk => clk,

		mux_h_c => mux_h_c_in, mux_atoh_c => mux_atoh_c_in,
		mux_123_c => mux_123_c_in,
		mux_4_c => mux_4_c_in,
		mux_5_c => mux_5_c_in,
		mux_6_c => mux_6_c_in,
		mux_7_c => mux_7_c_in,
		mux_8_c => mux_8_c_in,
		mux_9_c => mux_9_c_in,
		rc1_1 => rc1_1_in, rc2_1 => rc2_1_in, sen_1 => sen_1_in, sc_1 => sc_1_in,
		rc1_2 => rc1_2_in, rc2_2 => rc2_2_in, sen_2 => sen_2_in, sc_2 => sc_2_in,
		rc1_3 => rc1_3_in, rc2_3 => rc2_3_in, sen_3 => sen_3_in, sc_3 => sc_3_in,
		load16reg => load16reg_in,
		loadatoh => loadatoh_in,
		loadh => loadh_in,
		load48reg => load48reg_in,
		dmux_load48reg_c => dmux_load48reg_c_in,
		loadrg1 => loadrg1_in, loadrg2 => loadrg2_in, loadrg3 => loadrg3_in,
		loads0 => loads0_in, loads1 => loads1_in,
		loadtemp1 => loadtemp1_in, loadtemp2 => loadtemp2_in,

		t_c => t_c,
		t_i => shift_signal,
		o0 => o0,
		o1 => o1,
		o2 => o2,
		o3 => o3,
		o4 => o4,
		o5 => o5,
		o6 => o6,
		o7 => o7,
		t_o => t_o
	);

end Sha256_arch;