library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity RRo11 is
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end RRo11;  

--------------------------------------------------

architecture RRo11_arch of RRo11 is

constant r : integer := 11;

begin
	o(r to 31) <= i(0 to (31-r));
	o(0 to (r-1)) <= i((31-r+1) to 31);
end RRo11_arch;