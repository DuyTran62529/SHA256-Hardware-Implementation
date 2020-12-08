library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity FullAdd is
port(a, b, cin: in std_logic;
	cout: out std_logic;
	o: out std_logic
);
end FullAdd;  

--------------------------------------------------

architecture FullAdd_arch of FullAdd is

component XOR3x1
port(x, y, z: in std_logic;
	o: out std_logic
);
end component;

component AND2x1
port(x, y: in std_logic;
	o: out std_logic
);
end component;

component OR3x1
port(x, y, z: in std_logic;
	o: out std_logic
);
end component;

signal tmp1, tmp2, tmp3: std_logic;

begin
	--Add
	u1: XOR3x1
	port map(
		x => a,
		y => b,
		z => cin,
		o => o
	);

	--Carry
	u2: AND2x1
	port map(
		x => a,
		y => b,
		o => tmp1
	);

	u3: AND2x1
	port map(
		x => a,
		y => cin,
		o => tmp2
	);

	u4: AND2x1
	port map(
		x => b,
		y => cin,
		o => tmp3
	);

	u5: OR3x1
	port map(
		x => tmp1,
		y => tmp2,
		z => tmp3,
		o => cout
	);
	
end FullAdd_arch;