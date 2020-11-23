library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity State_m1 is
port(sm1: in std_logic;
	clk: in std_logic;
	mux_123_c_offset: out std_logic_vector (0 to 5);
	mux_123_c_offset_c: out std_logic;
	rc1_1, rc2_1, sen_1, sc_1: out std_logic;
	rc1_2, rc2_2, sen_2, sc_2: out std_logic;
	rc1_3, rc2_3, sen_3, sc_3: out std_logic;
	loadrg1, loadrg2, loadrg3: out std_logic;
	loads0, loads1: out std_logic;
	load48reg: out std_logic;
	done: out std_logic
);
end State_m1;  

--------------------------------------------------

architecture behav of State_m1 is

type state_type is (S0, S1, S2, S3, S4, S5, S6, S7);
signal state, next_state : state_type;

begin
	SYNC_PROC : process (clk)
	begin
		if rising_edge(clk) then
		 	if (sm1 = '0') then
		 		state <= S0;
		 	else
		 		state <= next_state;
		 	end if;
		end if;
	end process;

	NEXT_STATE_DECODE : process (clk, state)
	begin
		case (state) is
			when S0 =>
				if falling_edge(clk) then
					mux_123_c_offset <= "110000";
					mux_123_c_offset_c <= '1';

					rc1_1 <= '1';
					rc2_1 <= '0';
					sen_1 <= '0';

					rc1_2 <= '1';
					rc2_2 <= '1';
					sen_2 <= '0';

					rc1_3 <= '0';
					rc2_3 <= '1';
					sen_3 <= '0';

					loadrg1 <= '1';
					loadrg2 <= '1';
					loadrg3 <= '1';

					loads0 <= '0';
					loads1 <= '0';

					load48reg <= '0';

					done <= '0';
				end if;

				next_state <= S1;
			
			when S1 =>
				if falling_edge(clk) then
					mux_123_c_offset <= "000000";
					mux_123_c_offset_c <= '0';

					rc1_1 <= '0';
					rc2_1 <= '0';
					sen_1 <= '0';

					rc1_2 <= '1';
					rc2_2 <= '0';
					sen_2 <= '0';

					rc1_3 <= '0';
					rc2_3 <= '0';
					sen_3 <= '1';
					sc_3 <= '0';

					loadrg1 <= '1';
					loadrg2 <= '1';
					loadrg3 <= '1';

					loads0 <= '0';
					loads1 <= '0';

					load48reg <= '0';

					done <= '0';
				end if;

				next_state <= S2;

			when S2 =>
				if falling_edge(clk) then
					mux_123_c_offset <= "000000";
					mux_123_c_offset_c <= '0';

					rc1_2 <= '0';
					rc2_2 <= '0';
					sen_2 <= '0';

					loadrg1 <= '0';
					loadrg2 <= '1';
					loadrg3 <= '0';

					loads0 <= '0';
					loads1 <= '0';

					load48reg <= '0';

					done <= '0';
				end if;

				next_state <= S3;

			when S3 =>
				if falling_edge(clk) then
					mux_123_c_offset <= "111101";
					mux_123_c_offset_c <= '1';

					rc1_1 <= '1';
					rc2_1 <= '1';
					sen_1 <= '0';

					rc1_2 <= '1';
					rc2_2 <= '1';
					sen_2 <= '0';

					rc1_3 <= '1';
					rc2_3 <= '0';
					sen_3 <= '0';

					loadrg1 <= '1';
					loadrg2 <= '1';
					loadrg3 <= '1';

					loads0 <= '1';
					loads1 <= '0';

					load48reg <= '0';

					done <= '0';
				end if;

				next_state <= S4;

			when S4 =>
				if falling_edge(clk) then
					mux_123_c_offset <= "000000";
					mux_123_c_offset_c <= '0';

					rc1_1 <= '1';
					rc2_1 <= '0';
					sen_1 <= '0';

					rc1_2 <= '1';
					rc2_2 <= '0';
					sen_2 <= '0';

					rc1_3 <= '0';
					rc2_3 <= '1';
					sen_3 <= '0';

					loadrg1 <= '1';
					loadrg2 <= '1';
					loadrg3 <= '1';

					loads0 <= '0';
					loads1 <= '0';

					load48reg <= '0';

					done <= '0';
				end if;

				next_state <= S5;

			when S5 =>
				if falling_edge(clk) then
					mux_123_c_offset <= "000000";
					mux_123_c_offset_c <= '0';

					rc1_2 <= '0';
					rc2_2 <= '1';
					sen_2 <= '0';

					rc1_3 <= '0';
					rc2_3 <= '1';
					sen_3 <= '1';
					sc_3 <= '1';

					loadrg1 <= '0';
					loadrg2 <= '1';
					loadrg3 <= '1';

					loads0 <= '0';
					loads1 <= '0';

					load48reg <= '0';

					done <= '0';
				end if;

				next_state <= S6;

			when S6 =>
				if falling_edge(clk) then
					loadrg1 <= '0';
					loadrg2 <= '0';
					loadrg3 <= '0';

					loads0 <= '0';
					loads1 <= '1';

					load48reg <= '0';

					done <= '0';
				end if;
				
				next_state <= S7;
			
			when S7 =>
				if falling_edge(clk) then
					loadrg1 <= '0';
					loadrg2 <= '0';
					loadrg3 <= '0';

					loads0 <= '0';
					loads1 <= '0';

					load48reg <= '1';

					done <= '1';
				end if;

				next_state <= S0;
		end case;
	end process;
end behav;