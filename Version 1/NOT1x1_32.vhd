library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity NOT1x1_32 is
port(x: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end NOT1x1_32;  

--------------------------------------------------

architecture NOT1x1_32_arch of NOT1x1_32 is

component NOT1x1
port(x: in std_logic;
	o: out std_logic
);
end component;

begin
	gen_mux: for j in 0 to 31 generate
		ux: NOT1x1
		port map(
			x => x(j),
			o => o(j)
		);
	end generate gen_mux;
	
end NOT1x1_32_arch;