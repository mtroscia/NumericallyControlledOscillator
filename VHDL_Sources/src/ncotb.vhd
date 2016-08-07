-------------------------------------------------------------------------------
--
-- Title       : ncotb
-- Design      : Project
-- Author      : Martina
-- Company     : UNIPI
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Utente\Dropbox\_ECS\ES\Lab\_Project\Project\src\ncotb.vhd
-- Generated   : Wed Apr 13 15:26:45 2016
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ncotb is	 
	
end ncotb;

architecture ncotb_arch of ncotb is

	component nco is 
		generic ( 
			--bits for input
			N : INTEGER:= 16; 
			--bits for signal entering the LUT
			M : INTEGER:= 7;
			--bits for signal coming out from the LUT
			P : INTEGER:= 16;  
			--bits for amplitude signal
			Q : INTEGER:= 8
		);
		port (	 
			clock 		: in std_ulogic;   
			reset 		: in  std_ulogic; 
		
			frequency 	: in  std_ulogic_vector(N-1 downto 0);
			phase 		: in std_ulogic_vector(N-1 downto 0);
			amplitude 	: in std_ulogic_vector(Q-1 downto 0);
		
    		wave		: out std_ulogic_vector(P+Q-1 downto 0)
  	);
	end component nco;



	constant CLOCK_PERIOD  	:  time 	:= 200 ns;
	constant TEST_LEN 		:  integer  := 2000;     	   
	constant N	: integer	:= 16;
	constant M	: integer	:= 7;
	constant P	: integer	:= 16;
	constant Q	: integer	:= 8;

	-- I N P U T     S I G N A L S
	signal clk   	: std_ulogic := '0';
	signal rst	 	: std_ulogic := '1';	
	signal fr 		: std_ulogic_vector(N-1 downto 0) := "0000110000000000";
	signal ph 		: std_ulogic_vector(N-1 downto 0) := "0000000000001000";
	signal amp 		: std_ulogic_vector(Q-1 downto 0) := "10000000";	

	-- O U T P U T     S I G N A L S
	signal out_nco    	: std_ulogic_vector(P+Q-1 downto 0);
	signal clk_cycle 	: integer := 0;
	signal TEST			: boolean := true;
 
	begin
	
  	I: nco generic map (N=>N, M=>M, P=>P, Q=>Q)
  		port map(clock=>clk, reset=>rst, frequency=>fr, phase=>ph, amplitude=>amp, wave=>out_nco);

  -- Generate clk
	clk <= not clk after CLOCK_PERIOD/2 when TEST else '0';

  -- Run simulation for TEST_LEN cycles
	test_proc: process(clk)
    	variable COUNT: integer:= 0;
   		
		begin
     		clk_cycle <= (COUNT+1)/2;
			case COUNT is 
				when 1				=>	rst <= '0'; 
       		  	when 3				=> 	rst <= '1';	
				when 300			=>	fr <= "0000001110000000";
				when 800			=>	ph <= "0010000000000000";  
				when 1300			=>	amp <= "11111000";
		  		when (TEST_LEN - 1) =>	TEST <= false;
          		when others 		=> 	null;
     		end case;
			COUNT:= COUNT + 1;
   	end process test_proc;

end ncotb_arch;
