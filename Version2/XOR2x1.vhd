library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity XOR2x1 is
port(x, y: in std_logic;
	o: out std_logic
);
end XOR2x1;  

--------------------------------------------------

architecture behav of XOR2x1 is
begin
	o <= x xor y;
end behav;