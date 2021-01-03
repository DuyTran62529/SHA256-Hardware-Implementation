library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------
--Control signals MSB to LSB: c3 c2 c1 -----------
--------------------------------------------------

entity MUX8x1 is
port(i: in std_logic_vector(0 to 7);
	c1, c2, c3: in std_logic;
	o: out std_logic
);
end MUX8x1;  

--------------------------------------------------

architecture MUX8x1_arch of MUX8x1 is

component NOT1x1 is
port(x: in std_logic;
	o: out std_logic
);
end component;

component AND4x1
port(x, y, z, t: in std_logic;
	o: out std_logic
);
end component;

component OR4x1
port(x, y, z, t: in std_logic;
	o: out std_logic
);
end component;

component OR2x1
port(x, y: in std_logic;
	o: out std_logic
);
end component;

signal c1n, c2n, c3n: std_logic;
signal ngo: std_logic_vector(0 to 7);
signal ogo1, ogo2: std_logic;

begin
	--Inverse control signals
	u1: NOT1x1
	port map(
		x => c1,
		o => c1n
	);

	u2: NOT1x1
	port map(
		x => c2,
		o => c2n
	);

	u3: NOT1x1
	port map(
		x => c3,
		o => c3n
	);

	--And gates array
	aa1: AND4x1
	port map(
		x => c3n, 
		y => c2n, 
		z => c1n, 
		t => i(0),
		o => ngo(0)
	);

	aa2: AND4x1
	port map(
		x => c3n, 
		y => c2n, 
		z => c1, 
		t => i(1),
		o => ngo(1)
	);

	aa3: AND4x1
	port map(
		x => c3n, 
		y => c2, 
		z => c1n, 
		t => i(2),
		o => ngo(2)
	);

	aa4: AND4x1
	port map(
		x => c3n, 
		y => c2, 
		z => c1, 
		t => i(3),
		o => ngo(3)
	);

	aa5: AND4x1
	port map(
		x => c3, 
		y => c2n, 
		z => c1n, 
		t => i(4),
		o => ngo(4)
	);

	aa6: AND4x1
	port map(
		x => c3, 
		y => c2n, 
		z => c1, 
		t => i(5),
		o => ngo(5)
	);

	aa7: AND4x1
	port map(
		x => c3, 
		y => c2, 
		z => c1n, 
		t => i(6),
		o => ngo(6)
	);

	aa8: AND4x1
	port map(
		x => c3, 
		y => c2, 
		z => c1, 
		t => i(7),
		o => ngo(7)
	);

	--Output connection
	u4: OR4x1
	port map(
		x => ngo(0), 
		y => ngo(1), 
		z => ngo(2), 
		t => ngo(3),
		o => ogo1
	);

	u5: OR4x1
	port map(
		x => ngo(4), 
		y => ngo(5), 
		z => ngo(6), 
		t => ngo(7),
		o => ogo2
	);

	u6: OR2x1
	port map(
		x => ogo1, 
		y => ogo2, 
		o => o
	);
end MUX8x1_arch;