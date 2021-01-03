library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity XOR3x1 is
port(x, y, z: in std_logic;
	o: out std_logic
);
end XOR3x1;  

--------------------------------------------------

architecture behav of XOR3x1 is
begin
	o <= x xor y xor z;
end behav;