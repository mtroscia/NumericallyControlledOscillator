library IEEE;
use IEEE.std_logic_1164.all;

entity adder is

   generic (N : INTEGER:=4);
   port( a          : in  std_ulogic_VECTOR (N-1 downto 0);
         b          : in  std_ulogic_VECTOR (N-1 downto 0);
         cin	    : in  std_ulogic;
         s          : out std_ulogic_VECTOR (N-1 downto 0);
         cout		: out std_ulogic
	);

end adder;

architecture add_arch of adder is

begin
    sum: 
		process(a, b, cin)
			variable C: std_ulogic;
			begin
				C := cin;
				for i in 0 to N-1 loop
					s(i) <= a(i) XOR b(i) XOR C;
					C := (a(i) AND b(i)) OR (a(i) AND C) OR (b(i) AND C);
				end loop;
				cout <= C;
	end process sum;

end add_arch;
