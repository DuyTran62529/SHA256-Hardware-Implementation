library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity MainCirc2 is
port(a, e, h, ch, maj: in std_logic_vector (0 to 31);
	mux_2: in std_logic_vector(0 to 31);
	kmux_c: in std_logic_vector(0 to 5);

	temp1, temp2: out std_logic_vector(0 to 31)
);
end MainCirc2;  

--------------------------------------------------

architecture MainCirc2_arch of MainCirc2 is

component k_reg
port(k_out: out std_logic_vector (0 to 2047)
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

component RRo6
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

component RRo11
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

component RRo25
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

component RRo2
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

component RRo13
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

component RRo22
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

constant bl: integer := 32;

signal k_o: std_logic_vector(0 to 2047);
signal kmux_o: std_logic_vector(0 to 31);
signal rr6_o, rr11_o, rr25_o: std_logic_vector(0 to 31);
signal rr2_o, rr13_o, rr22_o: std_logic_vector(0 to 31);
signal xor1_o, xor2_o: std_logic_vector(0 to 31);
signal add1_o, add2_o, add3_o: std_logic_vector(0 to 31);


begin
	--kreg--
	uk: k_reg
	port map(
		k_out => k_o
	);

	--kmux--
	ukmux: MUX64x1_32
	port map(
		i => k_o,
		c => kmux_c,
		o => kmux_o
	);

	--RRO6--
	u0: RRo6
	port map(
		i => e,
		o => rr6_o
	);

	--RRO11--
	u1: RRo11
	port map(
		i => e,
		o => rr11_o
	);

	--RRO11--
	u2: RRo25
	port map(
		i => e,
		o => rr25_o
	);

	--RRO2--
	u3: RRo2
	port map(
		i => a,
		o => rr2_o
	);

	--RRO13--
	u4: RRo13
	port map(
		i => a,
		o => rr13_o
	);

	--RSh22--
	u5: RRo22
	port map(
		i => a,
		o => rr22_o
	);

	--XOR1--
	u6: XOR3x1_32
	port map(
		x => rr6_o,
		y => rr11_o,
		z => rr25_o,
		o => xor1_o
	);

	--XOR2--
	u7: XOR3x1_32
	port map(
		x => rr2_o,
		y => rr13_o,
		z => rr22_o,
		o => xor2_o
	);

	--Add1--
	u8: Add32
	port map(
		a => xor1_o,
		b => mux_2,
		o => add1_o
	);

	--Add2--
	u9: Add32
	port map(
		a => add1_o,
		b => h,
		o => add2_o
	);	

	--Add3--
	u10: Add32
	port map(
		a => add2_o,
		b => ch,
		o => add3_o
	);

	--Add4--
	u11: Add32
	port map(
		a => add3_o,
		b => kmux_o,
		o => temp1
	);

	--Add5--
	u12: Add32
	port map(
		a => xor2_o,
		b => maj,
		o => temp2
	);
end MainCirc2_arch;