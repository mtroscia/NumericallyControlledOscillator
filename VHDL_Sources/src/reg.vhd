library IEEE;
use IEEE.std_logic_1164.all;

entity reg is
   
	generic (N: integer:=4);
  	port(d          : in  std_ulogic_vector(N-1 downto 0);
         clk        : in  std_ulogic;
         reset      : in  std_ulogic;
         q          : out std_ulogic_vector(N-1 downto 0)
	);

end reg;


architecture reg_arch of reg is

	component dff
		port (
			clk	: 	in std_ulogic;
			reset : in std_ulogic;
			d : 	in std_ulogic;
			q : 	out std_ulogic
  		);
	end component dff;

	begin
		Ireg: 
			for i in 0 to N-1 generate
				i_ff : dff
					port map (clk=>clk, reset=>reset, d=>d(i), q=>q(i));
			end generate Ireg;
end reg_arch;

