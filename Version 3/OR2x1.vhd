library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity OR2x1 is
port(x, y: in std_logic;
	o: out std_logic
);
end OR2x1;  

--------------------------------------------------

architecture behav of OR2x1 is
begin
	o <= x or y;
end behav;