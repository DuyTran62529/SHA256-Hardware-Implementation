library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity ch is
port(e, f, g: std_logic_vector(0 to 31);
	o: out std_logic_vector (0 to 31)
);
end ch;  

--------------------------------------------------

architecture ch_arch of ch is

component NOT1x1_32
port(x: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

component AND2x1_32
port(x, y: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

component XOR2x1_32
port(x, y: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end component;

signal not_o, and1_o, and2_o: std_logic_vector (0 to 31);

begin
	u0: NOT1x1_32
	port map
	(
		x => e,
		o => not_o
	);

	u1: AND2x1_32
	port map
	(
		x => e,
		y => f,
		o => and1_o
	);

	u2: AND2x1_32
	port map
	(
		x => not_o,
		y => g,
		o => and2_o
	);

	u3: XOR2x1_32
	port map
	(
		x => and1_o,
		y => and2_o,
		o => o
	);

end ch_arch;