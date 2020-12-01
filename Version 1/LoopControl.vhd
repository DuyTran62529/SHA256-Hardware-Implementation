library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity LoopControl is
port(incre, t_c, t_i, clk, load_16: in std_logic;
	t_o, equal63: out std_logic;
	o: out std_logic_vector (0 to 5)
);
end LoopControl;  

--------------------------------------------------

architecture LoopControl_arch of LoopControl is

component LoopCounter
port(incre, t_c, t_i, clk, load_16: in std_logic;
	t_o: out std_logic;
	o: out std_logic_vector (0 to 5)
);
end component;

component BinaryComp_6
port(x, y: in std_logic_vector (0 to 5);
	o: out std_logic
);
end component;

signal lc_o: std_logic_vector (0 to 5);

begin
	u0: LoopCounter
	port map
	(
		incre => incre, 
		t_c => t_c, 
		t_i => t_i, 
		clk => clk, 
		load_16 => load_16,
		t_o => t_o,
		o => lc_o
	);

	u1: BinaryComp_6
	port map
	(
		x => "111111",
		y => lc_o,
		o => equal63
	);

	o <= lc_o;

end LoopControl_arch;