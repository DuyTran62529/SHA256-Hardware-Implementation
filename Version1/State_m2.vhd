library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity State_m2 is
port(sm2: in std_logic;
	clk: in std_logic;
	mux_123_c_mask_1: out std_logic;
	mux_123_c_mask_0: out std_logic;
	rc1_1, rc2_1, sen_1, sc_1: out std_logic;
	rc1_2, rc2_2, sen_2, sc_2: out std_logic;
	rc1_3, rc2_3, sen_3, sc_3: out std_logic;
	loadrg1, loadrg2, loadrg3: out std_logic;
	loads0, loads1: out std_logic;
	mux_4_c, mux_6_c, mux_8_c: out std_logic;
	loadtemp1, loadtemp2: out std_logic;
	done: out std_logic
);
end State_m2;  

--------------------------------------------------

architecture behav of State_m2 is

type state_type is (S0, S1, S2, S3, S4, S5, S6, S7);
signal state, next_state : state_type;

begin
	SYNC_PROC : process (clk)
	begin
		if rising_edge(clk) then
		 	if (sm2 = '0') then
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
					mux_123_c_mask_1 <= '0';
					mux_123_c_mask_0 <= '1';

					rc1_1 <= '1';
					rc2_1 <= '0';
					sen_1 <= '0';

					rc1_2 <= '1';
					rc2_2 <= '1';
					sen_2 <= '0';

					rc1_3 <= '1';
					rc2_3 <= '1';
					sen_3 <= '0';

					loadrg1 <= '1';
					loadrg2 <= '1';
					loadrg3 <= '1';

					loads0 <= '0';
					loads1 <= '0';

					loadtemp1 <= '0';
					loadtemp2 <= '0';

					done <= '0';
				end if;

				next_state <= S1;
			
			when S1 =>
				if falling_edge(clk) then
					mux_123_c_mask_1 <= '0';
					mux_123_c_mask_0 <= '0';

					rc1_3 <= '1';
					rc2_3 <= '1';
					sen_3 <= '0';

					loadrg1 <= '0';
					loadrg2 <= '0';
					loadrg3 <= '1';

					loads0 <= '0';
					loads1 <= '0';

					loadtemp1 <= '0';
					loadtemp2 <= '0';

					done <= '0';
				end if;

				next_state <= S2;

			when S2 =>
				if falling_edge(clk) then
					mux_123_c_mask_1 <= '0';
					mux_123_c_mask_0 <= '0';

					rc1_3 <= '0';
					rc2_3 <= '1';
					sen_3 <= '0';

					loadrg1 <= '0';
					loadrg2 <= '0';
					loadrg3 <= '1';

					loads0 <= '0';
					loads1 <= '0';

					loadtemp1 <= '0';
					loadtemp2 <= '0';

					done <= '0';
				end if;

				next_state <= S3;

			when S3 =>
				if falling_edge(clk) then
					mux_123_c_mask_1 <= '0';
					mux_123_c_mask_0 <= '0';

					rc1_3 <= '0';
					rc2_3 <= '0';
					sen_3 <= '0';

					loadrg1 <= '0';
					loadrg2 <= '0';
					loadrg3 <= '1';

					loads0 <= '0';
					loads1 <= '0';

					loadtemp1 <= '0';
					loadtemp2 <= '0';

					done <= '0';
				end if;

				next_state <= S4;

			when S4 =>
				if falling_edge(clk) then
					mux_123_c_mask_1 <= '1';
					mux_123_c_mask_0 <= '0';

					rc1_1 <= '0';
					rc2_1 <= '1';
					sen_1 <= '0';

					rc1_2 <= '1';
					rc2_2 <= '1';
					sen_2 <= '0';

					rc1_3 <= '1';
					rc2_3 <= '1';
					sen_3 <= '0';

					loadrg1 <= '1';
					loadrg2 <= '1';
					loadrg3 <= '1';

					loads0 <= '0';
					loads1 <= '1';

					loadtemp1 <= '0';
					loadtemp2 <= '0';

					done <= '0';
				end if;

				next_state <= S5;

			when S5 =>
				if falling_edge(clk) then
					mux_123_c_mask_1 <= '0';
					mux_123_c_mask_0 <= '0';

					rc1_2 <= '0';
					rc2_2 <= '1';
					sen_2 <= '0';

					rc1_3 <= '1';
					rc2_3 <= '1';
					sen_3 <= '0';

					loadrg1 <= '0';
					loadrg2 <= '1';
					loadrg3 <= '1';

					mux_4_c <= '1';
					mux_6_c <= '1';
					mux_8_c <= '0';

					loads0 <= '0';
					loads1 <= '0';

					loadtemp1 <= '1';
					loadtemp2 <= '0';

					done <= '0';
				end if;

				next_state <= S6;

			when S6 =>
				if falling_edge(clk) then
					loadrg1 <= '0';
					loadrg2 <= '0';
					loadrg3 <= '0';

					loads0 <= '1';
					loads1 <= '0';

					loadtemp1 <= '0';
					loadtemp2 <= '0';

					done <= '0';
				end if;
				
				next_state <= S7;
			
			when S7 =>
				if falling_edge(clk) then
					loadrg1 <= '0';
					loadrg2 <= '0';
					loadrg3 <= '0';

					mux_4_c <= '0';
					mux_6_c <= '1';
					mux_8_c <= '1';

					loads0 <= '0';
					loads1 <= '0';

					loadtemp1 <= '0';
					loadtemp2 <= '1';

					done <= '1';
				end if;

				next_state <= S0;
		end case;
	end process;
end behav;