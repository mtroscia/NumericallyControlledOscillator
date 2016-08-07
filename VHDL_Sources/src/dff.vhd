library IEEE;
use IEEE.std_logic_1164.all;

entity dff is
	port
	(	d		: in  std_logic;
      	clk     : in  std_logic;
       	reset   : in  std_logic;
       	q       : out std_logic
	);
end dff;

architecture dff_arch of dff is

begin
    idff: 
		process(clk)
			begin
			if (clk'EVENT AND clk='1') then
				q <= reset AND d;
			end if;
    end process idff;

end dff_arch;