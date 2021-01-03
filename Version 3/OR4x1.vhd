library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity OR4x1 is
port(x, y, z, t: in std_logic;
	o: out std_logic
);
end OR4x1;  

--------------------------------------------------

architecture behav of OR4x1 is
begin
	o <= x or y or z or t;
end behav;