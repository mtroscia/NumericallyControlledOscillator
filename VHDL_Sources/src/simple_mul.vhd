-------------------------------------------------------------------------------
--
-- Title       : simple_mul
-- Design      : Project
-- Author      : Martina
-- Company     : UNIPI
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\Utente\Dropbox\_ECS\ES\Lab\_Project\Project\src\simple_mul.vhd
-- Generated   : Sun Apr 10 10:31:29 2016
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

entity simple_mul is  
	generic (M : INTEGER:=4);
	port( 
   			a	: in std_ulogic_vector (M-1 downto 0);    
			bi	: in std_ulogic;   
  
			prod: out std_ulogic_vector (M-1 downto 0)
	);
end simple_mul;


architecture simple_mul_arch of simple_mul is
begin

	imul: 
		process(a, bi)
			begin
				for i in 0 to M-1 loop
					prod(i) <= a(i) AND bi;
				end loop;
	 end process imul;

end simple_mul_arch;
