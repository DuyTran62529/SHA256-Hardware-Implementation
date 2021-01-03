library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity DEMUX2x1 is
port(i: in std_logic;
	c: in std_logic;
	o1, o2: out std_logic
);
end DEMUX2x1;  

--------------------------------------------------

architecture DEMUX2x1_arch of DEMUX2x1 is

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

signal cnot: std_logic;

begin
	u0: NOT1x1
	port map(
		x => c,
		o => cnot
	);

	u1: AND2x1
	port map(
		x => i,
		y => cnot,
		o => o1
	);

	u2: AND2x1
	port map(
		x => i,
		y => c,
		o => o2
	);
	
end DEMUX2x1_arch;