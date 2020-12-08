library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity w_reg is
port(i_0_15: in std_logic_vector (0 to 511);
	i_16_63: in std_logic_vector (0 to 31);
	clk, load16, load48, t_c, t_i: in std_logic;
	load48dmux: in std_logic_vector(0 to 5); 
	o: out std_logic_vector (0 to 2047);
	t_o: out std_logic
);
end w_reg;  

--------------------------------------------------

architecture w_reg_arch of w_reg is

component BitReg_32
port(i: in std_logic_vector (0 to 31);
	clk, load, t_c, t_i: in std_logic;
	o: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end component;

component DEMUX48x1
port(i: in std_logic;
	c : in std_logic_vector(0 to 5);
	o: out std_logic_vector(0 to 47)
);
end component;

signal load48dmux_o: std_logic_vector (0 to 47);
signal shift_signal1: std_logic_vector (0 to 16);
signal shift_signal2: std_logic_vector (0 to 48);

begin
	--First 16 registers--
	shift_signal1(0) <= t_i;

	gen_reg1: for j in 0 to 15 generate
		ux1: BitReg_32
		port map(
			i => i_0_15 (j*32 to (j*32 + 31)),
			clk => clk,
			load => load16,
			t_c => t_c,
			t_i => shift_signal1(j),
			o => o (j*32 to (j*32 + 31)),
			t_o => shift_signal1(j + 1)
		);
	end generate gen_reg1;

	--Load48 DEMUX--
	u0: DEMUX48x1
	port map(
		i => load48,
		c => load48dmux,
		o => load48dmux_o
	);

	--48 Remmaining registers--
	shift_signal2(0) <= shift_signal1(16);

	gen_reg2: for t in 0 to 47 generate
		ux1: BitReg_32
		port map(
			i => i_16_63,
			clk => clk,
			load => load48dmux_o(t),
			t_c => t_c,
			t_i => shift_signal2(t),
			o => o ((t + 16) * 32 to ((t + 16) * 32 + 31)),
			t_o => shift_signal2(t + 1)
		);
	end generate gen_reg2;

	t_o <= shift_signal2(48);

end w_reg_arch;