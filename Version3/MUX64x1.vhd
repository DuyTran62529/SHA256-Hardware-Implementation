library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------
--Control signals MSB to LSB: c6 c5 c4 c3 c2 c1---
--------------------------------------------------

entity MUX64x1 is
port(i: in std_logic_vector(0 to 63);
	c1, c2, c3, c4, c5, c6: in std_logic;
	o: out std_logic
);
end MUX64x1;  

--------------------------------------------------

architecture MUX64x1_arch of MUX64x1 is

component MUX8x1
port(i: in std_logic_vector(0 to 7);
	c1, c2, c3: in std_logic;
	o: out std_logic
);
end component;

signal muxo: std_logic_vector(0 to 7);

begin
	--Layer 1 muxes
	gen_mux: for j in 0 to 7 generate
		ux: MUX8x1
		port map(
			i => i((j*8)  to (j*8+7)),
			c1 => c1,
			c2 => c2,
			c3 => c3,
			o => muxo(j)
		);
	end generate gen_mux;

	--Layer 2 mux
	u0: MUX8x1
	port map(
		i => muxo,
		c1 => c4,
		c2 => c5,
		c3 => c6,
		o => o
	);	

end MUX64x1_arch;