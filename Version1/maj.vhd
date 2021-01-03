library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity maj is
port(a, b, c: std_logic_vector(0 to 31);
	o: out std_logic_vector (0 to 31)
);
end maj;  

--------------------------------------------------

architecture maj_arch of maj is

component AND2x1_32
port(x, y: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

component XOR3x1_32
port(x, y, z: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

signal and1_o, and2_o, and3_o: std_logic_vector (0 to 31);

begin
	u0: AND2x1_32
	port map
	(
		x => a,
		y => b,
		o => and1_o
	);

	u1: AND2x1_32
	port map
	(
		x => a,
		y => c,
		o => and2_o
	);

	u2: AND2x1_32
	port map
	(
		x => b,
		y => c,
		o => and3_o
	);

	u3: XOR3x1_32
	port map
	(
		x => and1_o,
		y => and2_o,
		z => and3_o,
		o => o
	);

end maj_arch;