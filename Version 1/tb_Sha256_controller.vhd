library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;

--------------------------------------------------

entity tb_Sha256_controller is
end tb_Sha256_controller;  

--------------------------------------------------

architecture tb_Sha256_controller_arch of tb_Sha256_controller is

component Sha256_controller
port(start, rst, initial: in std_logic;
	clk: in std_logic;
	t_c, t_i: in std_logic;
	mux_h_c, mux_atoh_c: out std_logic;
	mux_123_c: out std_logic_vector (0 to 5);
	mux_4_c: out std_logic;
	mux_5_c: out std_logic_vector (0 to 5);
	mux_6_c: out std_logic;
	mux_7_c: out std_logic_vector (0 to 5);
	mux_8_c: out std_logic;
	mux_9_c: out std_logic_vector (0 to 5);
	rc1_1, rc2_1, sen_1, sc_1: out std_logic;
	rc1_2, rc2_2, sen_2, sc_2: out std_logic;
	rc1_3, rc2_3, sen_3, sc_3: out std_logic;
	load16reg: out std_logic;
	loadatoh: out std_logic;
	loadh: out std_logic;
	load48reg: out std_logic;
	dmux_load48reg_c: out std_logic_vector (0 to 5);
	loadrg1, loadrg2, loadrg3: out std_logic;
	loads0, loads1: out std_logic;
	loadtemp1, loadtemp2: out std_logic;
	ready, t_o: out std_logic
);
end component;

signal start, rst, initial: std_logic := '0';
signal clk: std_logic := '0';
signal t_c, t_i: std_logic := '0';
signal mux_h_c, mux_atoh_c: std_logic;
signal mux_123_c: std_logic_vector (0 to 5);
signal mux_4_c: std_logic;
signal mux_5_c: std_logic_vector (0 to 5);
signal mux_6_c: std_logic;
signal mux_7_c: std_logic_vector (0 to 5);
signal mux_8_c: std_logic;
signal mux_9_c: std_logic_vector (0 to 5);
signal rc1_1, rc2_1, sen_1, sc_1: std_logic;
signal rc1_2, rc2_2, sen_2, sc_2: std_logic;
signal rc1_3, rc2_3, sen_3, sc_3: std_logic;
signal load16reg: std_logic;
signal loadatoh: std_logic;
signal loadh: std_logic;
signal load48reg: std_logic;
signal dmux_load48reg_c: std_logic_vector (0 to 5);
signal loadrg1, loadrg2, loadrg3: std_logic;
signal loads0, loads1: std_logic;
signal loadtemp1, loadtemp2: std_logic;
signal ready, t_o: std_logic;

constant hp: time := 5ns;

begin
	DUT: Sha256_controller
	port map(
		start, rst, initial,
		clk,
		t_c, t_i,
		mux_h_c, mux_atoh_c,
		mux_123_c,
		mux_4_c,
		mux_5_c,
		mux_6_c,
		mux_7_c,
		mux_8_c,
		mux_9_c,
		rc1_1, rc2_1, sen_1, sc_1,
		rc1_2, rc2_2, sen_2, sc_2,
		rc1_3, rc2_3, sen_3, sc_3,
		load16reg,
		loadatoh,
		loadh,
		load48reg,
		dmux_load48reg_c,
		loadrg1, loadrg2, loadrg3,
		loads0, loads1,
		loadtemp1, loadtemp2,
		ready, t_o
	);

	clk <= not clk after hp;	

	main: process
	begin
		t_c <= '1';
		wait for 14*hp;
		t_c <= '0';
		start <= '1';
		initial <= '1';
		wait for 2*hp;
		start <= '0';
		initial <= '0';

		wait for 2*hp;
		while (ready = '0') loop
			wait for 2*hp;
		end loop;

		wait for 14*hp;
		stop;
	end process main;
	
end tb_Sha256_controller_arch; 