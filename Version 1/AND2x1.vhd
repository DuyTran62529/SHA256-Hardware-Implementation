library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity AND2x1 is
port(x, y: in std_logic;
	o: out std_logic
);
end AND2x1;  

--------------------------------------------------

architecture behav of AND2x1 is
begin
	o <= x and y;
end behav;