library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------
--------------------------------------------------

entity DEMUX8x1 is
port(i: in std_logic;
	c: in std_logic_vector(0 to 2);
	o: out std_logic_vector(0 to 7)
);
end DEMUX8x1;  

--------------------------------------------------

architecture DEMUX8x1_arch of DEMUX8x1 is

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

signal cn: std_logic_vector(0 to 2);

begin
	--Inverse control signals
	u1: NOT1x1
	port map(
		x => c(0),
		o => cn(0)
	);

	u2: NOT1x1
	port map(
		x => c(1),
		o => cn(1)
	);

	u3: NOT1x1
	port map(
		x => c(2),
		o => cn(2)
	);

	--And gates array
	aa1: AND4x1
	port map(
		x => i, 
		y => cn(0), 
		z => cn(1), 
		t => cn(2),
		o => o(0)
	);

	aa2: AND4x1
	port map(
		x => i, 
		y => cn(0), 
		z => cn(1), 
		t => c(2),
		o => o(1)
	);

	aa3: AND4x1
	port map(
		x => i, 
		y => cn(0), 
		z => c(1), 
		t => cn(2),
		o => o(2)
	);

	aa4: AND4x1
	port map(
		x => i, 
		y => cn(0), 
		z => c(1), 
		t => c(2),
		o => o(3)
	);

	aa5: AND4x1
	port map(
		x => i, 
		y => c(0), 
		z => cn(1), 
		t => cn(2),
		o => o(4)
	);

	aa6: AND4x1
	port map(
		x => i, 
		y => c(0), 
		z => cn(1), 
		t => c(2),
		o => o(5)
	);

	aa7: AND4x1
	port map(
		x => i, 
		y => c(0), 
		z => c(1), 
		t => cn(2),
		o => o(6)
	);

	aa8: AND4x1
	port map(
		x => i, 
		y => c(0), 
		z => c(1), 
		t => c(2),
		o => o(7)
	);

end DEMUX8x1_arch;