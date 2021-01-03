library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity AND4x1 is
port(x, y, z, t: in std_logic;
	o: out std_logic
);
end AND4x1;  

--------------------------------------------------

architecture behav of AND4x1 is
begin
	o <= x and y and z and t;
end behav;