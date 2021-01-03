library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity FF_reg is
port(i, t_i, clk, t_c: in std_logic;
	o, t_o: out std_logic
);
end FF_reg;  

--------------------------------------------------

architecture FF_reg_arch of FF_reg is

component MUX2x1
port(a, b: in std_logic;
	c: in std_logic;
	o: out std_logic
);
end component;

component DFF_POS
port(d, en: in std_logic;
	q: out std_logic
);
end component;

signal m_o, p_ff: std_logic;

begin
	u0: MUX2x1
	port map(
		a => i,
		b => t_i,
		c => t_c,
		o => m_o
	);

	u1: DFF_POS
	port map(
		d => m_o,
		en => clk,
		q => p_ff
	);

	o <= p_ff;
	t_o <= p_ff;
	
end FF_reg_arch;