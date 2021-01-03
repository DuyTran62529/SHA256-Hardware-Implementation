library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

--------------------------------------------------

entity tb_MainCir1 is
end tb_MainCir1;  

--------------------------------------------------

architecture tb_MainCir1_arch of tb_MainCir1 is

component MainCir1
port(i: in std_logic_vector (0 to 2015);
	clk: in std_logic;
	mux_123: in std_logic_vector (0 to 5);
	rc1_1, rc2_1, sen_1, sc_1: in std_logic;
	rc1_2, rc2_2, sen_2, sc_2: in std_logic;
	rc1_3, rc2_3, sen_3, sc_3: in std_logic;
	loadrg1, loadrg2, loadrg3: in std_logic;
	loads0, loads1: in std_logic;
	t_c, t_i: in std_logic;
	s0, s1: out std_logic_vector (0 to 31);
	t_o: out std_logic
);
end component;

signal i: std_logic_vector(0 to 2015) := X"000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
signal clk: std_logic := '0';
signal mux_123: std_logic_vector(0 to 5) := "000000";
signal rc1_1, rc2_1, sen_1, sc_1: std_logic := '0';
signal rc1_2, rc2_2, sen_2, sc_2: std_logic := '0';
signal rc1_3, rc2_3, sen_3, sc_3: std_logic := '0';
signal loadrg1, loadrg2, loadrg3: std_logic := '0';
signal loads0, loads1: std_logic := '0';
signal t_c, t_i: std_logic := '0';
signal s0, s1: std_logic_vector (0 to 31);
signal t_o: std_logic;

constant hp : time := 10ns;

begin
	DUT: MainCir1
	port map(
		i,
		clk,
		mux_123,
		rc1_1, rc2_1, sen_1, sc_1,
		rc1_2, rc2_2, sen_2, sc_2,
		rc1_3, rc2_3, sen_3, sc_3,
		loadrg1, loadrg2, loadrg3,
		loads0, loads1,
		t_c, t_i,
		s0, s1,
		t_o
	);

	clk <= not clk after hp;

	main: process
	begin
		--Stand by--
		wait for 4*hp;

		--S0--
		mux_123 <= "000001";
		rc1_1 <= '1';
		rc2_1 <= '0';
		sen_1 <= '0';
		loadrg1 <= '1';

		rc1_2 <= '1';
		rc2_2 <= '1';
		sen_2 <= '0';
		loadrg2 <= '1';
		
		rc1_3 <= '0';
		rc2_3 <= '1';
		sen_3 <= '0';
		loadrg3 <= '1';

		wait for 2*hp;

		mux_123 <= "111111";
		rc1_1 <= '0';
		rc2_1 <= '0';
		sen_1 <= '0';
		loadrg1 <= '1';

		rc1_2 <= '1';
		rc2_2 <= '0';
		sen_2 <= '0';
		loadrg2 <= '1';
		
		rc1_3 <= '0';
		rc2_3 <= '0';
		sen_3 <= '1';
		sc_3 <= '0';
		loadrg3 <= '1';

		wait for 2*hp;

		mux_123 <= "111111";
		rc1_1 <= '0';
		rc2_1 <= '0';
		sen_1 <= '0';
		loadrg1 <= '0';

		rc1_2 <= '0';
		rc2_2 <= '0';
		sen_2 <= '0';
		loadrg2 <= '1';
		
		rc1_3 <= '0';
		rc2_3 <= '0';
		sen_3 <= '0';
		loadrg3 <= '0';

		wait for 2*hp;

		--S1--
		loads0 <= '1';
		mux_123 <= "000001";
		rc1_1 <= '1';
		rc2_1 <= '1';
		sen_1 <= '0';
		loadrg1 <= '1';

		rc1_2 <= '1';
		rc2_2 <= '1';
		sen_2 <= '0';
		loadrg2 <= '1';
		
		rc1_3 <= '1';
		rc2_3 <= '0';
		sen_3 <= '0';
		loadrg3 <= '1';
		
		wait for 2*hp;

		loads0 <= '0';
		mux_123 <= "111111";
		rc1_1 <= '1';
		rc2_1 <= '0';
		sen_1 <= '0';
		loadrg1 <= '1';

		rc1_2 <= '1';
		rc2_2 <= '0';
		sen_2 <= '0';
		loadrg2 <= '1';
		
		rc1_3 <= '0';
		rc2_3 <= '1';
		sen_3 <= '0';
		loadrg3 <= '1';
		
		wait for 2*hp;

		mux_123 <= "111111";
		rc1_1 <= '0';
		rc2_1 <= '0';
		sen_1 <= '0';
		loadrg1 <= '0';

		rc1_2 <= '0';
		rc2_2 <= '1';
		sen_2 <= '0';
		loadrg2 <= '1';
		
		rc1_3 <= '0';
		rc2_3 <= '1';
		sen_3 <= '1';
		sc_3 <= '1';
		loadrg3 <= '1';
		
		wait for 2*hp;

		--Final State--
		loadrg2 <= '0';
		sen_3 <= '0';
		sc_3 <= '0';		
		loadrg3 <= '0';
		loads1 <= '1';
		wait for 2*hp;

		--Stand by--
		loads1 <= '0';
		wait for 10*hp;
		
		stop;
	end process main;
	
end tb_MainCir1_arch; 