library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------
--Bits right rotate and right shift; bitwise XOR--
--results; output S0 and S1-----------------------
--------------------------------------------------

entity MainCir1 is
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
end MainCir1;  

--------------------------------------------------

architecture MainCir1_arch of MainCir1 is

component MUX64x1_32
port(i: in std_logic_vector (0 to 2047);
	c: in std_logic_vector (0 to 5);
	o: out std_logic_vector (0 to 31)
);
end component;

component Rotate_Shift
port(i: in std_logic_vector(0 to 31);
	rc1, rc2: in std_logic;
	sen, sc: in std_logic;
	o: out std_logic_vector(0 to 31)
);
end component;

component BitReg_32
port(i: in std_logic_vector (0 to 31);
	clk, load, t_c, t_i: in std_logic;
	o: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end component;

component XOR3x1_32
port(x, y, z: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

signal mux1_o, mux2_o, mux3_o: std_logic_vector (0 to 31);
signal rs1_o, rs2_o, rs3_o: std_logic_vector (0 to 31);
signal reg1_o, reg2_o, reg3_o: std_logic_vector (0 to 31);
signal xor_o: std_logic_vector (0 to 31);
signal shift_signal: std_logic_vector (0 to 3);

begin
	--Mux connections--
	u0: MUX64x1_32
	port map(
		i(0 to 2015) => i(0 to 2015),
		i(2016 to 2047) => reg1_o,
		c => mux_123,
		o => mux1_o
	);

	u1: MUX64x1_32
	port map(
		i(0 to 2015) => i(0 to 2015),
		i(2016 to 2047) => reg2_o,
		c => mux_123,
		o => mux2_o
	);

	u3: MUX64x1_32
	port map(
		i(0 to 2015) => i(0 to 2015),
		i(2016 to 2047) => reg3_o,
		c => mux_123,
		o => mux3_o
	);

	--Rotate_shift connections--
	u4: Rotate_Shift
	port map(
		i => mux1_o,
		rc1 => rc1_1, 
		rc2 => rc2_1,
		sen => sen_1, 
		sc => sc_1,
		o => rs1_o
	);

	u5: Rotate_Shift
	port map(
		i => mux2_o,
		rc1 => rc1_2, 
		rc2 => rc2_2,
		sen => sen_2, 
		sc => sc_2,
		o => rs2_o
	);

	u6: Rotate_Shift
	port map(
		i => mux3_o,
		rc1 => rc1_3, 
		rc2 => rc2_3,
		sen => sen_3, 
		sc => sc_3,
		o => rs3_o
	);

	--Hold register--
	u7: BitReg_32
	port map(
		i => rs1_o,
		clk => clk, 
		load => loadrg1, 
		t_c => t_c, 
		t_i => t_i,
		o => reg1_o,
		t_o => shift_signal(0)
	);

	u8: BitReg_32
	port map(
		i => rs2_o,
		clk => clk, 
		load => loadrg2, 
		t_c => t_c, 
		t_i => shift_signal(0),
		o => reg2_o,
		t_o => shift_signal(1)
	);

	u9: BitReg_32
	port map(
		i => rs3_o,
		clk => clk, 
		load => loadrg3, 
		t_c => t_c, 
		t_i => shift_signal(1),
		o => reg3_o,
		t_o => shift_signal(2)
	);

	--XOR--
	u10: XOR3x1_32
	port map(
		x => reg1_o, 
		y => reg2_o, 
		z => reg3_o ,
		o => xor_o
	);

	--S0--
	u11: BitReg_32
	port map(
		i => xor_o,
		clk => clk, 
		load => loads0, 
		t_c => t_c, 
		t_i => shift_signal(2),
		o => s0,
		t_o => shift_signal(3)
	);

	--S1--
	u12: BitReg_32
	port map(
		i => xor_o,
		clk => clk, 
		load => loads1, 
		t_c => t_c, 
		t_i => shift_signal(3),
		o => s1,
		t_o => t_o
	);

end MainCir1_arch;