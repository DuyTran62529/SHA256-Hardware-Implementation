library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity RRo22 is
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end RRo22;  

--------------------------------------------------

architecture RRo22_arch of RRo22 is

constant r : integer := 22;

begin
	o(r to 31) <= i(0 to (31-r));
	o(0 to (r-1)) <= i((31-r+1) to 31);
end RRo22_arch;