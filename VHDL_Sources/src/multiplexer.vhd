
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity multiplexer is
	generic ( N: integer := 4);
	port 
	(
		sel: in std_ulogic;
		opt1: in std_ulogic_vector(N-1 downto 0);
		opt2: in std_ulogic_vector(N-1 downto 0);
		output: out std_ulogic_vector(N-1 downto 0)
	);
end multiplexer;

architecture multiplexer_arch of multiplexer is
	begin
		output <= opt1 when (sel='1') else opt2;
end multiplexer_arch;
