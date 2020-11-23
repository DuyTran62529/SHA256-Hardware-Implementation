library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity RRo_mod is
port(a, b, c, d: in std_logic;
	c1, c2, c1n, c2n: in std_logic;
	o: out std_logic
);
end RRo_mod;  

--------------------------------------------------

architecture RRo_mod_arch of RRo_mod is

component AND3x1
port(x, y, z: in std_logic;
	o: out std_logic
);
end component;

component OR4x1
port(x, y, z, t: in std_logic;
	o: out std_logic
);
end component;

signal s1o, s2o, s6o, s11o: std_logic;

begin
	--Shft1_AND
	u1: AND3x1
	port map(
		x => a,
		y => c1n,
		z => c2n,
		o => s1o
	);

	--Shft2_AND
	u2: AND3x1
	port map(
		x => b,
		y => c1n,
		z => c2,
		o => s2o
	);

	--Shft6_AND
	u3: AND3x1
	port map(
		x => c,
		y => c1,
		z => c2n,
		o => s6o
	);

	--Shft11_AND
	u4: AND3x1
	port map(
		x => d,
		y => c1,
		z => c2,
		o => s11o
	);

	--ORg
	u5: OR4x1
	port map(
		x => s1o,
		y => s2o,
		z => s6o,
		t => s11o,
		o => o
	);

end RRo_mod_arch;