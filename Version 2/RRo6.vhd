library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity RRo6 is
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end RRo6;  

--------------------------------------------------

architecture RRo6_arch of RRo6 is

constant r : integer := 6;

begin
	o(r to 31) <= i(0 to (31-r));
	o(0 to (r-1)) <= i((31-r+1) to 31);
end RRo6_arch;