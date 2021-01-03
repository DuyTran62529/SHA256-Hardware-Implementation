library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity Add32 is
port(a, b: in std_logic_vector(0 to 31);
	o: out std_logic_vector(0 to 31)
);
end Add32;  

--------------------------------------------------

architecture Add32_arch of Add32 is

component FullAdd
port(a, b, cin: in std_logic;
	cout: out std_logic;
	o: out std_logic
);
end component;

constant bl: integer := 32;

signal c_holder: std_logic_vector(0 to (bl-2));

begin
	--Initial bit add
	u31: FullAdd
	port map(
		a => a(bl-1),
		b => b(bl-1),
		cin => '0',
		cout => c_holder(0),
		o => o(bl-1)
	);

	--30 bit add
	gen_add: for i in 1 to (bl-2) generate
		ux: FullAdd
		port map(
			a => a((bl-1) - i),
			b => b((bl-1) - i),
			cin => c_holder(i - 1),
			cout => c_holder(i),
			o => o((bl-1) - i)
		);
	end generate gen_add;

	--Last bit add
	u0: FullAdd
	port map(
		a => a(0),
		b => b(0),
		cin => c_holder(bl-2),
		o => o(0)
	);
end Add32_arch;