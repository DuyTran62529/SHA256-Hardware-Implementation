library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------
--MSB to LSB: rc1 rc2-----------------------------
--------------------------------------------------
entity Rotate_Shift is
port(i: in std_logic_vector(0 to 31);
	rc1, rc2: in std_logic;
	sen, sc: in std_logic;
	o: out std_logic_vector(0 to 31)
);
end Rotate_Shift;  

--------------------------------------------------

architecture Rotate_Shift_arch of Rotate_Shift is

component RRo is
port(i: in std_logic_vector(0 to 31);
	c1, c2: in std_logic;
	o: out std_logic_vector(0 to 31)
);
end component;

component NOT1x1 is
port(x: in std_logic;
	o: out std_logic
);
end component;

component AND2x1
port(x, y: in std_logic;
	o: out std_logic
);
end component;

component OR2x1
port(x, y: in std_logic;
	o: out std_logic
);
end component;

signal tmp: std_logic_vector(0 to 9);
signal sen_n, sc_n, senORsc: std_logic;

begin
	--Core connection
	uc: RRo
	port map(
		i => i,
		c1 => rc1,
		c2 => rc2,
		o(0 to 9) => tmp,
		o(10 to 31) => o(10 to 31)
	);

	--Inverse signal
	u0: NOT1x1
	port map(
		x => sen,
		o => sen_n
	);

	u1: NOT1x1
	port map(
		x => sc,
		o => sc_n
	);

	--Mask 3 MSB
	gen_mask_3: for j in 0 to 2 generate
		ugs3: AND2x1
		port map(
			x => tmp(j),
			y => sen_n,
			o => o(j)
		);
	end generate gen_mask_3;


	--Mask 10 MSB
	gen_mask_10: for j in 3 to 9 generate
		ugs10_1: OR2x1
		port map(
			x => sen_n,
			y => sc_n,
			o => senORsc
		);

		ugs10_2: AND2x1
		port map(
			x => tmp(j),
			y => senORsc,
			o => o(j)
		);
	end generate gen_mask_10;

end Rotate_Shift_arch;