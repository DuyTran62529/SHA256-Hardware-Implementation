library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity RRo18 is
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end RRo18;  

--------------------------------------------------

architecture RRo18_arch of RRo18 is

constant r : integer := 18;

begin
	o(r to 31) <= i(0 to (31-r));
	o(0 to (r-1)) <= i((31-r+1) to 31);
end RRo18_arch;