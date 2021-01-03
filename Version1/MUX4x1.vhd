library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------
--Control signals MSB to LSB: c2 c1 --------------
--------------------------------------------------

entity MUX4x1 is
port(a, b, c, d: in std_logic;
	c1, c2: in std_logic;
	o: out std_logic
);
end MUX4x1;  

--------------------------------------------------

architecture MUX4x1_arch of MUX4x1 is

component OR4x1
port(x, y, z, t: in std_logic;
	o: out std_logic
);
end component;

component AND3x1
port(x, y, z: in std_logic;
	o: out std_logic
);
end component;

component NOT1x1
port(x: in std_logic;
	o: out std_logic
);
end component;

signal c1not, c2not, and1, and2, and3, and4: std_logic;

begin
	u0: NOT1x1
	port map(
		x => c1,
		o => c1not
	);

	u1: NOT1x1
	port map(
		x => c2,
		o => c2not
	);

	u2: AND3x1
	port map(
		x => a,
		y => c1not,
		z => c2not,
		o => and1
	);

	u3: AND3x1
	port map(
		x => b,
		y => c1,
		z => c2not,
		o => and2
	);

	u4: AND3x1
	port map(
		x => c,
		y => c1not,
		z => c2,
		o => and3
	);

	u5: AND3x1
	port map(
		x => d,
		y => c1,
		z => c2,
		o => and4
	);

	u6: OR4x1
	port map(
		x => and1,
		y => and2,
		z => and3,
		t => and4,
		o => o
	);
	
end MUX4x1_arch;