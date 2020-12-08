library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity RSh10 is
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end RSh10;  

--------------------------------------------------

architecture RSh10_arch of RSh10 is

constant r : integer := 10;

constant mask_array : std_logic_vector (0 to (r-1)) := "0000000000";

begin
	o(r to 31) <= i(0 to (31-r));
	o(0 to (r-1)) <= mask_array;
end RSh10_arch;