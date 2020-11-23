library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------
--Additions; load to register;---------------------
--------------------------------------------------

entity MainCir2 is
port(s0, h, s1, ch, maj: in std_logic_vector (0 to 31);
	mux5_in: in std_logic_vector (0 to 1535);
	mux7_in, mux9_in: in std_logic_vector (0 to 2047);
	mux4_c, mux6_c, mux8_c: in std_logic;
	mux5_c: in std_logic_vector (0 to 5);
	mux7_c, mux9_c: in std_logic_vector (0 to 5);
	clk: in std_logic;
	temp1_load, temp2_load: in std_logic;
	t_c, t_i: in std_logic;
	temp1, temp2, reg_o: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end MainCir2;  

--------------------------------------------------

architecture MainCir2_arch of MainCir2 is

component MUX2x1_32
port(a, b: in std_logic_vector (0 to 31);
	c: in std_logic;
	o: out std_logic_vector (0 to 31)
);
end component;

component MUX64x1_32
port(i: in std_logic_vector (0 to 2047);
	c: in std_logic_vector (0 to 5);
	o: out std_logic_vector (0 to 31)
);
end component;

component MUX48x1_32
port(i: in std_logic_vector (0 to 1535);
	c: in std_logic_vector (0 to 5);
	o: out std_logic_vector (0 to 31)
);
end component;

component Add32
port(a, b: in std_logic_vector(0 to 31);
	o: out std_logic_vector(0 to 31)
);
end component;

component BitReg_32
port(i: in std_logic_vector (0 to 31);
	clk, load, t_c, t_i: in std_logic;
	o: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end component;

constant bl: integer := 32;

signal mux4_o, mux5_o, mux6_o, mux7_o, mux8_o, mux9_o: std_logic_vector (0 to 31);
signal add1_o, add2_o, add3_o, add4_o: std_logic_vector (0 to 31);
signal shift_signal: std_logic;

begin
	--Mux connection(4)--
	u0: MUX2x1_32
	port map(
		a => s0, 
		b => h,
		c => mux4_c,
		o => mux4_o
	);

	--Mux connection(5)--
	u1: MUX48x1_32
	port map(
		i => mux5_in,
		c => mux5_c,
		o => mux5_o
	);

	--Mux connection(8)--
	u2: MUX2x1_32
	port map(
		a => ch, 
		b => maj,
		c => mux8_c,
		o => mux8_o
	);

	--Mux connection(6)--
	u3: MUX2x1_32
	port map(
		a => mux5_o, 
		b => mux8_o,
		c => mux6_c,
		o => mux6_o
	);	

	--Mux connection(7)--
	u4: MUX64x1_32
	port map(
		i => mux7_in,
		c => mux7_c,
		o => mux7_o
	);

	--Mux connection(9)--
	u5: MUX64x1_32
	port map(
		i => mux9_in,
		c => mux9_c,
		o => mux9_o
	);

	--Adder(1)--
	u6: Add32
	port map(
		a => mux4_o, 
		b => mux6_o,
		o => add1_o
	);

	--Adder(2)--
	u7: Add32
	port map(
		a => s1, 
		b => mux7_o,
		o => add2_o
	);

	--Temp2--
	u8: BitReg_32
	port map(
		i => add1_o,
		clk => clk,
		load => temp2_load, 
		t_c => t_c, 
		t_i => shift_signal,
		o => temp2,
		t_o => t_o
	);

	--Adder(3)--
	u9: Add32
	port map(
		a => add1_o, 
		b => add2_o,
		o => add3_o
	);

	reg_o <= add3_o;

	--Adder(4)--
	u10: Add32
	port map(
		a => add3_o, 
		b => mux9_o,
		o => add4_o
	);

	--Temp1--
	u11: BitReg_32
	port map(
		i => add4_o,
		clk => clk,
		load => temp1_load, 
		t_c => t_c, 
		t_i => t_i,
		o => temp1,
		t_o => shift_signal
	);	
end MainCir2_arch;