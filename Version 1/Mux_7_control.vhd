library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity Mux_7_control is
port(i: in std_logic_vector (0 to 5);
	sm: in std_logic;
	o: out std_logic_vector (0 to 5)
);
end Mux_7_control;  

--------------------------------------------------

architecture Mux_7_control_arch of Mux_7_control is

component Add6
port(a, b: in std_logic_vector(0 to 5);
	o: out std_logic_vector(0 to 5)
);
end component;

component MUX2x1_6
port(a, b: in std_logic_vector (0 to 5);
	c: in std_logic;
	o: out std_logic_vector (0 to 5)
);
end component;

signal add_o: std_logic_vector(0 to 5);

begin
	--Adder--
	u0: Add6
	port map(
		a => i,
		b => "111001",
		o => add_o
	);

	--Mux--
	u1: MUX2x1_6
	port map(
		a => add_o, 
		b => i,
		c => sm,
		o => o
	);
end Mux_7_control_arch;