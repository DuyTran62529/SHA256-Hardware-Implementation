library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity DEMUX48x1 is
port(i: in std_logic;
	c : in std_logic_vector(0 to 5);
	o: out std_logic_vector(0 to 47)
);
end DEMUX48x1;  

--------------------------------------------------

architecture DEMUX48x1_arch of DEMUX48x1 is

component DEMUX2x1
port(i: in std_logic;
	c: in std_logic;
	o1, o2: out std_logic
);
end component;

component DEMUX4x1
port(i: in std_logic;
	c: in std_logic_vector (0 to 1);
	o: out std_logic_vector (0 to 3)
);
end component;

component DEMUX8x1
port(i: in std_logic;
	c: in std_logic_vector(0 to 2);
	o: out std_logic_vector(0 to 7)
);
end component;

signal dmuxo_1_2, dmuxo_1_4: std_logic;
signal dmuxo_2: std_logic_vector (0 to 5);

begin
	--Layer 1--
	u0: DEMUX2x1
	port map(
		i => i,
		c => c(0),
		o1 => dmuxo_1_2, 
		o2 => dmuxo_1_4
	);

	--Layer 2--
	u1: DEMUX2x1
	port map(
		i => dmuxo_1_2,
		c => c(2),
		o1 => dmuxo_2(0), 
		o2 => dmuxo_2(1)
	);

	u2: DEMUX4x1
	port map(
		i => dmuxo_1_4,
		c(0) => c(1),
		c(1) => c(2),
		o => dmuxo_2 (2 to 5)
	);

	--Layer 3--
	gen_mux: for j in 0 to 5 generate
		ux: DEMUX8x1
		port map(
			i => dmuxo_2 (j),
			c => c(3 to 5),
			o => o(j*8 to (j*8 + 7))
		);
	end generate gen_mux;
end DEMUX48x1_arch;