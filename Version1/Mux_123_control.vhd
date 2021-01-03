library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity Mux_123_control is
port(i: in std_logic_vector (0 to 5);
	mux_123_c_offset: in std_logic_vector (0 to 5);
	mux_123_c_offset_c: in std_logic;
	sm, mask1, mask0: in std_logic;
	o: out std_logic_vector (0 to 5)
);
end Mux_123_control;  

--------------------------------------------------

architecture Mux_123_control_arch of Mux_123_control is

component MUX2x1_6
port(a, b: in std_logic_vector (0 to 5);
	c: in std_logic;
	o: out std_logic_vector (0 to 5)
);
end component;

component NOT1x1_6
port(x: in std_logic_vector (0 to 5);
	o: out std_logic_vector (0 to 5)
);
end component;

component Add6
port(a, b: in std_logic_vector(0 to 5);
	o: out std_logic_vector(0 to 5)
);
end component;

component AND2x1
port(x, y: in std_logic;
	o: out std_logic
);
end component;

component NOT1x1
port(x: in std_logic;
	o: out std_logic
);
end component;

signal i_n: std_logic_vector (0 to 5);
signal offset_val: std_logic_vector (0 to 5);
signal add_o: std_logic_vector (0 to 5);
signal mask1_n, mask0_n, mux_bit1, mux_bit0: std_logic;

begin
	--Bitwise inverse i--
	u0: NOT1x1_6
	port map(
		x => i,
		o => i_n
	);

	--Offset mux--
	u1: MUX2x1_6
	port map(
		a => i_n, 
		b => mux_123_c_offset,
		c => mux_123_c_offset_c,
		o => offset_val
	);

	--Adder--
	u2: Add6
	port map(
		a => i,
		b => offset_val,
		o => add_o
	);

	--Mask 1--
	u3: NOT1x1
	port map(
		x => mask1,
		o => mask1_n
	);

	u4: AND2x1
	port map(
		x => '1',
		y => mask1_n,
		o => mux_bit1
	);

	--Mask 0--
	u5: NOT1x1
	port map(
		x => mask0,
		o => mask0_n
	);

	u6: AND2x1
	port map(
		x => '1',
		y => mask0_n,
		o => mux_bit0
	);

	--State mux--
	u7: MUX2x1_6
	port map(
		a => add_o, 
		b(0 to 3) => "1111",
		b(4) => mux_bit1,
		b(5) => mux_bit0,
		c => sm,
		o => o
	);

end Mux_123_control_arch;