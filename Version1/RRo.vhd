library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity RRo is
port(i: in std_logic_vector(0 to 31);
	c1, c2: in std_logic;
	o: out std_logic_vector(0 to 31)
);
end RRo;  

--------------------------------------------------

architecture RRo_arch of RRo is

component NOT1x1
port(x: in std_logic;
	o: out std_logic
);
end component;

component RRo_mod
port(a, b, c, d: in std_logic;
	c1, c2, c1n, c2n: in std_logic;
	o: out std_logic
);
end component;

signal c1_inv, c2_inv: std_logic;
signal tmp: std_logic_vector(0 to 31);

begin
	--Invert Control Signals
	u1: NOT1x1
	port map(
		x => c1,
		o => c1_inv
	);

	u2: NOT1x1
	port map(
		x => c2,
		o => c2_inv
	);

	--Right Rotate
	gen_reg: for k in 0 to 31 generate
    	uxx:  RRo_mod
    	port map(
    		a => i((k-1) mod 32),
    		b => i((k-2) mod 32),
    		c => i((k-6) mod 32),
    		d => i((k-11) mod 32),
    		c1 => c1,
    		c2 => c2,
    		c1n => c1_inv,
    		c2n => c2_inv,
    		o => o(k)
    	);
   	end generate gen_reg;
end RRo_arch;