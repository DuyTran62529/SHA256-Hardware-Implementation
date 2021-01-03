library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity OR3x1 is
port(x, y, z: in std_logic;
	o: out std_logic
);
end OR3x1;  

--------------------------------------------------

architecture behav of OR3x1 is
begin
	o <= x or y or z;
end behav;