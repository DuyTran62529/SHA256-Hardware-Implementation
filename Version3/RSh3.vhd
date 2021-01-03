library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity RSh3 is
port(i: in std_logic_vector (0 to 31);
	o: out std_logic_vector (0 to 31)
);
end RSh3;  

--------------------------------------------------

architecture RSh3_arch of RSh3 is

constant r : integer := 3;

constant mask_array : std_logic_vector (0 to (r-1)) := "000";

begin
	o(r to 31) <= i(0 to (31-r));
	o(0 to (r-1)) <= mask_array;
end RSh3_arch;