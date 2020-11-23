library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity MUX2x1 is
port(a, b: in std_logic;
	c: in std_logic;
	o: out std_logic
);
end MUX2x1;  

--------------------------------------------------

architecture MUX2x1_arch of MUX2x1 is

component OR2x1
port(x, y: in std_logic;
	o: out std_logic
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

signal cnot, and1, and2: std_logic;

begin
	u0: NOT1x1
	port map(
		x => c,
		o => cnot
	);

	u1: AND2x1
	port map(
		x => a,
		y => cnot,
		o => and1
	);

	u2: AND2x1
	port map(
		x => b,
		y => c,
		o => and2
	);

	u3: OR2x1
	port map(
		x => and1,
		y => and2,
		o => o
	);
	
end MUX2x1_arch;