library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity MUX2x1_6 is
port(a, b: in std_logic_vector (0 to 5);
	c: in std_logic;
	o: out std_logic_vector (0 to 5)
);
end MUX2x1_6;  

--------------------------------------------------

architecture MUX2x1_6_arch of MUX2x1_6 is

component MUX2x1
port(a, b: in std_logic;
	c: in std_logic;
	o: out std_logic
);
end component;

begin
	gen_mux: for j in 0 to 5 generate
		ux: MUX2x1
		port map(
			a => a(j),
			b => b(j),		
			c => c,
			o => o(j)
		);
	end generate gen_mux;
	
end MUX2x1_6_arch;