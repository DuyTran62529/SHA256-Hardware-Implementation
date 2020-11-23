library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity XNOR2x1 is
port(x, y: in std_logic;
	o: out std_logic
);
end XNOR2x1;  

--------------------------------------------------

architecture behav of XNOR2x1 is
begin
	o <= x xnor y;
end behav;