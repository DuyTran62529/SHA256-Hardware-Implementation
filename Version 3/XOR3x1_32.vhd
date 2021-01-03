library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity XOR3x1_32 is
port(x, y, z: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end XOR3x1_32;  

--------------------------------------------------

architecture XOR3x1_32_arch of XOR3x1_32 is

component XOR3x1
port(x, y, z: in std_logic;
	o: out std_logic
);

end component;

begin
	gen_mux: for j in 0 to 31 generate
		ux: XOR3x1
		port map(
			x => x(j),
			y => y(j),
			z => z(j),
			o => o(j)
		);
	end generate gen_mux;
	
end XOR3x1_32_arch;