library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity DFF_POS is
port(d, en: in std_logic;
	q: out std_logic
);
end DFF_POS;  

--------------------------------------------------

architecture behav of DFF_POS is
begin
	process(en)
	begin
		if (rising_edge(en)) then
			q <= d;
		end if;
	end process;
end behav;