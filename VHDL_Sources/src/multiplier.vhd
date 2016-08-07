library ieee;
use ieee.std_logic_1164.all;

entity multiplier is 
	
	generic (
		M: integer:=16;
		P: integer:=8
	);		
	
	port (
		a		: in std_ulogic_vector (M-1 downto 0);
		b		: in std_ulogic_vector (P-1 downto 0);
		prod	: out std_ulogic_vector (M+P-1 downto 0)
	);	 
	
end multiplier;


architecture mul_arch of multiplier is	  

	component simple_mul is  
		generic (M : INTEGER:=4);
		port( 
   				a	: in std_ulogic_vector (M-1 downto 0);    
				bi	: in std_ulogic;   
  
				prod: out std_ulogic_vector (M-1 downto 0)
		);
	end component simple_mul;

	component adder is

   	generic (N : INTEGER:=4);
   	port( 
	   		a		:	in  std_ulogic_VECTOR (N-1 downto 0);
         	b       : in  std_ulogic_VECTOR (N-1 downto 0);
         	cin	    : in  std_ulogic;
         	s       : out std_ulogic_VECTOR (N-1 downto 0);
         	cout	: out std_ulogic);
	end component adder;

	--signals to support outputs of simple_muls
	type outsmul_t is array (natural range 0 to P-1) of std_ulogic_vector(M-1 downto 0);	  
	signal outsmul : outsmul_t;

	--signals to create inputs for adders	 
	type inadd_t is array (natural range 0 to P-2) of std_ulogic_vector(M-1 downto 0);	  
	signal inadd : inadd_t;

	--signals to support outputs of adders
	type outadd_t is array (natural range 0 to P-2) of std_ulogic_vector(M-1 downto 0);	  
	signal outadd : outadd_t;

	--signals to support carry_outs of adders	
	type coutadd_t is array (natural range 0 to P-2) of std_ulogic;	  
	signal coutadd : coutadd_t;	  

	begin 
		--partial products computation
		mulvec: 
			for i in 0 to P-1 generate	  
				smul: simple_mul generic map (M) port map (a, b(i), outsmul(i));
	 		end generate mulvec;	 
		
		--link to adders the partial products to generate the output 
			inadd(0) <= '0' & outsmul(0)(M-1 downto 1);	
		add_wires: 
			for i in 1 to P-2 generate
				inadd(i) <= coutadd(i-1) & outadd(i-1)(M-1 downto 1);
			end generate add_wires;	
	
		addvec: 
			for i in 0 to P-2 generate	  
				sadd: adder generic map (M) port map (inadd(i), outsmul(i+1), '0', outadd(i), coutadd(i));
	 		end generate addvec;
		 
		--link the adder outputs to the one of the multiplier 
		--prod(0) takes the LSB of the first multiplication 
		prod(0) <= outsmul(0)(0);
		--from 1 to P-2 take the LSB of the additions computed by adder 1 to P-2
		mul_wires: 
			for i in 1 to P-2 generate
				prod(i) <= outadd(i-1)(0);
			end generate mul_wires;	 
		--from P-1 to M+P-2 take the multiplication computed by the P-1th adder
		prod(M+P-2 downto P-1) <= outadd(P-2)(M-1 downto 0);
		--MSB of the result takes the carry out of the P-1th adder
		prod(M+P-1) <= coutadd(P-2);
		
end mul_arch;
