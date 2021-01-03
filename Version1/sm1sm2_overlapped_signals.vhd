library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity sm1sm2_overlapped_signals is
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
end sm1sm2_overlapped_signals;  

--------------------------------------------------

architecture sm1sm2_overlapped_signals_arch of sm1sm2_overlapped_signals is

component MUX2x1
port(a, b: in std_logic;
	c: in std_logic;
	o: out std_logic
);
end component;

signal a: std_logic_vector(0 to 18);
signal b: std_logic_vector(0 to 18);
signal o: std_logic_vector(0 to 18);

begin
	a(0) <= sm1_rc1_1;
	a(1) <= sm1_rc2_1;
	a(2) <= sm1_sen_1;
	a(3) <= sm1_sc_1;
	a(4) <= sm1_rc1_2;
	a(5) <= sm1_rc2_2;
	a(6) <= sm1_sen_2;
	a(7) <= sm1_sc_2;
	a(8) <= sm1_rc1_3;
	a(9) <= sm1_rc2_3;
	a(10) <= sm1_sen_3;
	a(11) <= sm1_sc_3;
	a(12) <= sm1_loadrg1;
	a(13) <= sm1_loadrg2;
	a(14) <= sm1_loadrg3;
	a(15) <= sm1_loads0;
	a(16) <= sm1_loads1;
	a(17) <= '0';
	a(18) <= '0';

	b(0) <= sm2_rc1_1;
	b(1) <= sm2_rc2_1;
	b(2) <= sm2_sen_1;
	b(3) <= sm2_sc_1;
	b(4) <= sm2_rc1_2;
	b(5) <= sm2_rc2_2;
	b(6) <= sm2_sen_2;
	b(7) <= sm2_sc_2;
	b(8) <= sm2_rc1_3;
	b(9) <= sm2_rc2_3;
	b(10) <= sm2_sen_3;
	b(11) <= sm2_sc_3;
	b(12) <= sm2_loadrg1;
	b(13) <= sm2_loadrg2;
	b(14) <= sm2_loadrg3;
	b(15) <= sm2_loads0;
	b(16) <= sm2_loads1;
	b(17) <= sm2_mux_4_c;
	b(18) <= sm2_mux_6_c;

	rc1_1 <= o(0);
	rc2_1 <= o(1);
	sen_1 <= o(2);
	sc_1 <= o(3);
	rc1_2 <= o(4);
	rc2_2 <= o(5);
	sen_2 <= o(6);
	sc_2 <= o(7);
	rc1_3 <= o(8);
	rc2_3 <= o(9);
	sen_3 <= o(10);
	sc_3 <= o(11);
	loadrg1 <= o(12);
	loadrg2 <= o(13);
	loadrg3 <= o(14);
	loads0 <= o(15);
	loads1 <= o(16);
	mux_4_c <= o(17);
	mux_6_c <= o(18);

	gen_mux: for j in 0 to 18 generate
		ux: MUX2x1
		port map(
			a => a(j),
			b => b(j),		
			c => sm,
			o => o(j)
		);
	end generate gen_mux;
	
end sm1sm2_overlapped_signals_arch;