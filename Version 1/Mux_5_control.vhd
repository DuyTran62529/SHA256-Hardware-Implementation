library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity Mux_5_control is
port(i: in std_logic_vector (0 to 5);
	o: out std_logic_vector (0 to 5)
);
end Mux_5_control;  

--------------------------------------------------

architecture Mux_5_control_arch of Mux_5_control is

component Add6
port(a, b: in std_logic_vector(0 to 5);
	o: out std_logic_vector(0 to 5)
);
end component;

begin
	--Adder--
	u0: Add6
	port map(
		a => i,
		b => "110000",
		o => o
	);

end Mux_5_control_arch;