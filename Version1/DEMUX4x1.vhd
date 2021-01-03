library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity DEMUX4x1 is
port(i: in std_logic;
	c: in std_logic_vector (0 to 1);
	o: out std_logic_vector (0 to 3)
);
end DEMUX4x1;  

--------------------------------------------------

architecture DEMUX4x1_arch of DEMUX4x1 is

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

signal cn: std_logic_vector (0 to 1);

begin
	u0: NOT1x1
	port map(
		x => c(0),
		o => cn(0)
	);

	u1: NOT1x1
	port map(
		x => c(1),
		o => cn(1)
	);

	u2: AND3x1
	port map(
		x => i,
		y => cn(0),
		z => cn(1),
		o => o(0)
	);

	u3: AND3x1
	port map(
		x => i,
		y => cn(0),
		z => c(1),
		o => o(1)
	);

	u4: AND3x1
	port map(
		x => i,
		y => c(0),
		z => cn(1),
		o => o(2)
	);

	u5: AND3x1
	port map(
		x => i,
		y => c(0),
		z => c(1),
		o => o(3)
	);
	
end DEMUX4x1_arch;