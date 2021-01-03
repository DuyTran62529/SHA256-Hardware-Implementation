library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity RRo19 is
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end RRo19;  

--------------------------------------------------

architecture RRo19_arch of RRo19 is

constant r : integer := 19;

begin
	o(r to 31) <= i(0 to (31-r));
	o(0 to (r-1)) <= i((31-r+1) to 31);
end RRo19_arch;