library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity MUX48x1_32 is
port(i: in std_logic_vector (0 to 1535);
	c: in std_logic_vector (0 to 5);
	o: out std_logic_vector (0 to 31)
);
end MUX48x1_32;  

--------------------------------------------------

architecture MUX48x1_32_arch of MUX48x1_32 is

component MUX48x1
port(i: in std_logic_vector(0 to 47);
	c1, c2, c3, c4, c5, c6: in std_logic;
	o: out std_logic
);
end component;

constant bl: integer := 32;

begin
	gen_mux: for j in 0 to 31 generate
		ux: MUX48x1
		port map(
			i(0) => i(j + 0*bl),
			i(1) => i(j + 1*bl),
			i(2) => i(j + 2*bl),
			i(3) => i(j + 3*bl),
			i(4) => i(j + 4*bl),
			i(5) => i(j + 5*bl),
			i(6) => i(j + 6*bl),
			i(7) => i(j + 7*bl),
			i(8) => i(j + 8*bl),
			i(9) => i(j + 9*bl),
			i(10) => i(j + 10*bl),
			i(11) => i(j + 11*bl),
			i(12) => i(j + 12*bl),
			i(13) => i(j + 13*bl),
			i(14) => i(j + 14*bl),
			i(15) => i(j + 15*bl),
			i(16) => i(j + 16*bl),
			i(17) => i(j + 17*bl),
			i(18) => i(j + 18*bl),
			i(19) => i(j + 19*bl),
			i(20) => i(j + 20*bl),
			i(21) => i(j + 21*bl),
			i(22) => i(j + 22*bl),
			i(23) => i(j + 23*bl),
			i(24) => i(j + 24*bl),
			i(25) => i(j + 25*bl),
			i(26) => i(j + 26*bl),
			i(27) => i(j + 27*bl),
			i(28) => i(j + 28*bl),
			i(29) => i(j + 29*bl),
			i(30) => i(j + 30*bl),
			i(31) => i(j + 31*bl),
			i(32) => i(j + 32*bl),
			i(33) => i(j + 33*bl),
			i(34) => i(j + 34*bl),
			i(35) => i(j + 35*bl),
			i(36) => i(j + 36*bl),
			i(37) => i(j + 37*bl),
			i(38) => i(j + 38*bl),
			i(39) => i(j + 39*bl),
			i(40) => i(j + 40*bl),
			i(41) => i(j + 41*bl),
			i(42) => i(j + 42*bl),
			i(43) => i(j + 43*bl),
			i(44) => i(j + 44*bl),
			i(45) => i(j + 45*bl),
			i(46) => i(j + 46*bl),
			i(47) => i(j + 47*bl),		
			c1 => c(5),
			c2 => c(4),
			c3 => c(3),
			c4 => c(2),
			c5 => c(1),
			c6 => c(0),
			o => o(j)
		);
	end generate gen_mux;
	
end MUX48x1_32_arch;