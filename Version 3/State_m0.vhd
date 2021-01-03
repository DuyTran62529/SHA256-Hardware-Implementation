library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------

entity State_m0 is
port(start, rst, initial, loop_comp_47, loop_comp_63: in std_logic;
	clk: in std_logic;
	mux_h_c: out std_logic;
	loadh: out std_logic;
	load16reg: out std_logic;
	mux_atoh_c: out std_logic;
	loadatoh: out std_logic;
	load_16_63: out std_logic;
	loop_incre: out std_logic;
	ready: out std_logic
);
end State_m0;  

--------------------------------------------------

architecture behav of State_m0 is

type state_type is (S0, S1, S2, S3, S4, S5, S6, S7);
signal state, next_state : state_type;

begin
	SYNC_PROC : process (clk)
	begin
		if rising_edge(clk) then
		 	if (rst = '1') then
		 		state <= S0;
		 	else
		 		state <= next_state;
		 	end if;
		end if;
	end process;

	NEXT_STATE_DECODE : process (clk, state, start, initial, loop_comp_47, loop_comp_63)
	begin
		case (state) is
			when S0 =>
				mux_h_c <= '1';
				loadh <= '0';
				load16reg <= '0';
				mux_atoh_c <= '1';
				loadatoh <= '0';
				load_16_63 <= '0';
				loop_incre <= '0';
				ready <= '1';

				if (start = '1') then
					if (initial = '1') then
						next_state <= S1;
					else
						next_state <= S2;
					end if;
				else
					next_state <= S0;
				end if;
			
			when S1 =>
				mux_h_c <= '0';
				loadh <= '1';
				load16reg <= '0';
				mux_atoh_c <= '1';
				loadatoh <= '0';
				load_16_63 <= '0';
				loop_incre <= '0';
				ready <= '0';

				next_state <= S2;

			when S2 =>			
				mux_h_c <= '0';
				loadh <= '0';
				load16reg <= '1';
				mux_atoh_c <= '1';
				loadatoh <= '1';
				load_16_63 <= '0';
				loop_incre <= '0';
				ready <= '0';

				next_state <= S3;

			when S3 =>			
				mux_h_c <= '0';
				loadh <= '0';
				load16reg <= '0';
				mux_atoh_c <= '0';
				loadatoh <= '0';
				load_16_63 <= '0';
				loop_incre <= '1';
				ready <= '0';

				next_state <= S4;
				
			when S4 =>
				mux_h_c <= '0';
				loadh <= '0';
				load16reg <= '0';
				mux_atoh_c <= '0';
				loadatoh <= '1';
				load_16_63 <= '1';
				loop_incre <= '0';
				ready <= '0';
				
				if (loop_comp_47 = '1') then
					next_state <= S5;
				else
					next_state <= S3;
				end if;

			when S5 =>			
				mux_h_c <= '0';
				loadh <= '0';
				load16reg <= '0';
				mux_atoh_c <= '0';
				loadatoh <= '0';
				load_16_63 <= '0';
				loop_incre <= '1';
				ready <= '0';

				next_state <= S6;

			when S6 =>			
				mux_h_c <= '0';
				loadh <= '0';
				load16reg <= '0';
				mux_atoh_c <= '0';
				loadatoh <= '1';
				load_16_63 <= '0';
				loop_incre <= '0';
				ready <= '0';
				
				if (loop_comp_63 = '1') then
					next_state <= S7;
				else
					next_state <= S5;
				end if;
			
			when S7 =>
				mux_h_c <= '0';
				loadh <= '1';
				load16reg <= '0';
				mux_atoh_c <= '0';
				loadatoh <= '0';
				load_16_63 <= '0';
				loop_incre <= '0';
				ready <= '0';
				
				next_state <= S0;
		end case;
	end process;
end behav;