library IEEE;
use IEEE.std_logic_1164.all;

entity accumulator is 
	generic (N : INTEGER:=4);
   	port(
	   	 fw         : in  std_ulogic_vector(N-1 downto 0);
         clk        : in  std_ulogic;
         reset      : in  std_ulogic;
         ph		  	: out std_ulogic_vector(N-1 downto 0)
	);
end accumulator;


architecture acc_arch of accumulator is	

	component adder
		generic (N : INTEGER:=4);
   		port( 
		   	a		: in  std_ulogic_VECTOR (N-1 downto 0);
         	b       : in  std_ulogic_VECTOR (N-1 downto 0);
         	cin   	: in  std_ulogic;
         	s       : out std_ulogic_VECTOR (N-1 downto 0);
         	cout  	: out std_ulogic
		);
	end component adder;

	component reg
		generic (N: integer:=4);
  		port(
		  	d		: in  std_ulogic_vector(N-1 downto 0);
        	clk     : in  std_ulogic;
         	reset   : in  std_ulogic;
         	q       : out std_ulogic_vector(N-1 downto 0)
		);
	end component reg;

	signal reg_to_add: std_ulogic_vector(N-1 downto 0);
	signal add_to_reg: std_ulogic_vector(N-1 downto 0);

	begin  
		Iadd: 
			adder generic map (N=>N)
				port map (a=>fw, b=>reg_to_add, cin=>'0', s=>add_to_reg, cout=>open);
		Ireg: 
			reg generic map (N=>N)
				port map (d=>add_to_reg, clk=>clk, reset=>reset, q=>reg_to_add);  
		ph<=add_to_reg;
		
end acc_arch;