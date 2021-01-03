library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity DFF_NEG is
port(d, en: in std_logic;
	q: out std_logic
);
end DFF_NEG;  

--------------------------------------------------

architecture behav of DFF_NEG is
begin
	process(en)
	begin
		if (falling_edge(en)) then
			q <= d;
		end if;
	end process;
end behav;