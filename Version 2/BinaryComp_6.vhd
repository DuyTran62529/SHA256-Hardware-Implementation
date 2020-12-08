library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity BinaryComp_6 is
port(x, y: in std_logic_vector (0 to 5);
	o: out std_logic
);
end BinaryComp_6;  

--------------------------------------------------

architecture BinaryComp_6_arch of BinaryComp_6 is

component XNOR2x1
port(x, y: in std_logic;
	o: out std_logic
);
end component;

component AND3x1
port(x, y, z: in std_logic;
	o: out std_logic
);
end component;

component AND2x1
port(x, y: in std_logic;
	o: out std_logic
);
end component;

signal xnor_o: std_logic_vector (0 to 5);
signal layer1_and1, layer1_and2: std_logic;

begin
	gen_mux: for j in 0 to 5 generate
		ux: XNOR2x1
		port map(
			x => x(j),
			y => y(j),
			o => xnor_o(j)
		);
	end generate gen_mux;

	u0: AND3x1
	port map(
		x => xnor_o(0), 
		y => xnor_o(1), 
		z => xnor_o(2),
		o => layer1_and1
	);

	u1: AND3x1
	port map(
		x => xnor_o(3), 
		y => xnor_o(4), 
		z => xnor_o(5),
		o => layer1_and2
	);

	u2: AND2x1
	port map(
		x => layer1_and1, 
		y => layer1_and2, 
		o => o
	);	
end BinaryComp_6_arch;