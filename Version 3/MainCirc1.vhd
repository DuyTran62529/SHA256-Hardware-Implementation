library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity MainCirc1 is
port(i: in std_logic_vector (0 to 511);
	clk: in std_logic;
	t_c, t_i: in std_logic;
	t_o: out std_logic;
	mux_2: out std_logic_vector(0 to 31);

	mux_dmux_c: in std_logic_vector(0 to 5);
	loadwreg: in std_logic;
	loadreg_16_63: in std_logic
);
end MainCirc1;  

--------------------------------------------------

architecture MainCirc1_arch of MainCirc1 is

component w_reg
port(i_0_15: in std_logic_vector (0 to 511);
	i_16_63: in std_logic_vector (0 to 31);
	clk, load16, load48, t_c, t_i: in std_logic;
	load48dmux: in std_logic_vector(0 to 5); 
	o: out std_logic_vector (0 to 2047);
	t_o: out std_logic
);
end component;

component MUX48x1_32
port(i: in std_logic_vector (0 to 1535);
	c: in std_logic_vector (0 to 5);
	o: out std_logic_vector (0 to 31)
);
end component;

component MUX64x1_32
port(i: in std_logic_vector (0 to 2047);
	c: in std_logic_vector (0 to 5);
	o: out std_logic_vector (0 to 31)
);
end component;

component Add32
port(a, b: in std_logic_vector(0 to 31);
	o: out std_logic_vector(0 to 31)
);
end component;

component XOR3x1_32
port(x, y, z: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

--Rotators & shifters--

component RRo7
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

component RRo18
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

component RSh3
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

component RRo17
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

component RRo19
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

component RSh10
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

constant bl: integer := 32;

signal wreg_o: std_logic_vector(0 to 2047);
signal mux_I_o: std_logic_vector(0 to 31);
signal mux_II_o: std_logic_vector(0 to 31);
signal mux_1_o, mux_2_o: std_logic_vector(0 to 31);
signal rr7_o, rr18_o, rs3_o: std_logic_vector(0 to 31);
signal rr17_o, rr19_o, rs10_o: std_logic_vector(0 to 31);
signal xor1_o, xor2_o: std_logic_vector(0 to 31);
signal add1_o, add2_o, add3_o: std_logic_vector(0 to 31);


begin
	--w reg intake--
	u0: w_reg
	port map(
		i_0_15 => i,
		i_16_63 => add3_o,
		clk => clk,
		load16 => loadwreg,
		load48 => loadreg_16_63,
		t_c => t_c,
		t_i => t_i,
		load48dmux => mux_dmux_c,
		o => wreg_o,
		t_o => t_o
	);

	--Mux (I)--
	u1: MUX48x1_32
	port map(
		i => wreg_o((1*bl) to (48*bl + (bl-1))),
		c => mux_dmux_c,
		o => mux_I_o
	);

	--Mux (II)--
	u2: MUX48x1_32
	port map(
		i => wreg_o((14*bl) to (61*bl + (bl-1))),
		c => mux_dmux_c,
		o => mux_II_o
	);

	--Mux 1--
	u3: MUX48x1_32
	port map(
		i => wreg_o((9*bl) to (56*bl + (bl-1))),
		c => mux_dmux_c,
		o => mux_1_o
	);

	--Mux 2--
	u4: MUX64x1_32
	port map(
		i => wreg_o((0*bl) to (63*bl + (bl-1))),
		c => mux_dmux_c,
		o => mux_2_o
	);

	mux_2 <= mux_2_o;

	--RRO7--
	u5: RRo7
	port map(
		i => mux_I_o,
		o => rr7_o
	);

	--RRO18--
	u6: RRo18
	port map(
		i => mux_I_o,
		o => rr18_o
	);

	--RSh3--
	u7: RSh3
	port map(
		i => mux_I_o,
		o => rs3_o
	);

	--RRO17--
	u8: RRo17
	port map(
		i => mux_II_o,
		o => rr17_o
	);

	--RRO19--
	u9: RRo19
	port map(
		i => mux_II_o,
		o => rr19_o
	);

	--RSh10--
	u10: RSh10
	port map(
		i => mux_II_o,
		o => rs10_o
	);

	--XOR1--
	u11: XOR3x1_32
	port map(
		x => rr7_o,
		y => rr18_o,
		z => rs3_o,
		o => xor1_o
	);

	--XOR2--
	u12: XOR3x1_32
	port map(
		x => rr17_o,
		y => rr19_o,
		z => rs10_o,
		o => xor2_o
	);

	--Add1--
	u13: Add32
	port map(
		a => xor1_o,
		b => xor2_o,
		o => add1_o
	);

	--Add2--
	u14: Add32
	port map(
		a => mux_1_o,
		b => add1_o,
		o => add2_o
	);	

	--Add3--
	u15: Add32
	port map(
		a => add2_o,
		b => mux_2_o,
		o => add3_o
	);	

end MainCirc1_arch;