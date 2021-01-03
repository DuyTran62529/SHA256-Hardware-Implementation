library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity AND3x1 is
port(x, y, z: in std_logic;
	o: out std_logic
);
end AND3x1;  

--------------------------------------------------

architecture behav of AND3x1 is
begin
	o <= x and y and z;
end behav;