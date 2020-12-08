library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity NOT1x1 is
port(x: in std_logic;
	o: out std_logic
);
end NOT1x1;  

--------------------------------------------------

architecture behav of NOT1x1 is
begin
	o <= not x;
end behav;