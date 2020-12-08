library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity XOR2x1_32 is
port(x, y: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end XOR2x1_32;  

--------------------------------------------------

architecture XOR2x1_32_arch of XOR2x1_32 is

component XOR2x1
port(x, y: in std_logic;
	o: out std_logic
);

end component;

begin
	gen_mux: for j in 0 to 31 generate
		ux: XOR2x1
		port map(
			x => x(j),
			y => y(j),
			o => o(j)
		);
	end generate gen_mux;
	
end XOR2x1_32_arch;