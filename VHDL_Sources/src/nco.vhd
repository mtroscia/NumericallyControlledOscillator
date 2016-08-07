-------------------------------------------------------------------------------
--
-- Title       : nco
-- Design      : Project
-- Author      : Martina
-- Company     : UNIPI
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Utente\Dropbox\_ECS\ES\Lab\_Project\Project\src\nco.vhd
-- Generated   : Sat Apr  9 14:34:34 2016
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

entity nco is 
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
end nco;


architecture nco_arch of nco is	 

	component accumulator is 
		generic (N : INTEGER:=4);
   		port(
	   		 fw      : in  std_ulogic_vector(N-1 downto 0);
        	 clk     : in  std_ulogic;
        	 reset   : in  std_ulogic;
        	 ph		 : out std_ulogic_vector(N-1 downto 0)
		);
	end component accumulator;	

	component adder
		generic (N : INTEGER:=4);
		port( 
			 a       : in  std_ulogic_VECTOR (N-1 downto 0);
        	 b       : in  std_ulogic_VECTOR (N-1 downto 0);
         	 cin	 : in  std_ulogic;
        	 s       : out std_ulogic_VECTOR (N-1 downto 0);
         	 cout  	 : out std_ulogic
		);
	end component adder;

	component LUT_UN_SIN_32x16 is
  		port (
    		  phase 	: in  std_ulogic_vector(6 downto 0);
			  datao 	: out std_ulogic_vector(15 downto 0) 
  		);
	end component LUT_UN_SIN_32x16;

	component multiplier is
		generic (
			M: integer:=8;
			P: integer:=8
		);
		port (
			a		: in std_ulogic_vector (M-1 downto 0);
			b		: in std_ulogic_vector (P-1 downto 0);
			prod	: out std_ulogic_vector (M+P-1 downto 0)
		);
	end component multiplier;
	
	--utility signals
	signal acc_to_add: std_ulogic_vector(N-1 downto 0);
	signal add_to_lut: std_ulogic_vector(N-1 downto 0);
	signal lut_to_mul: std_ulogic_vector(P-1 downto 0);
	
	begin
		
		Iacc: accumulator generic map (N=>N)
			port map (fw=>frequency, clk=>clock, reset=>reset, ph=>acc_to_add);
		
		Iadd: adder generic map (N=>N)
			port map (a=>phase, b=>acc_to_add, cin=>'0', s=>add_to_lut, cout=>open);  	
		
		Ilut: LUT_UN_SIN_32x16	  
			port map (phase=>add_to_lut(N-1 downto N-7), datao=>lut_to_mul);	
			
		Imul: multiplier generic map (M=>Q, P=>P) 
			port map (a=>amplitude, b=>lut_to_mul, prod=>wave);	 

end nco_arch;
