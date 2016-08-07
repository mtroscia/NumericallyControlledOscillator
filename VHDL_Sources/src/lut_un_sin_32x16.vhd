
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity LUT_UN_SIN_32x16 is
	port (
		phase : in  std_ulogic_vector(6 downto 0);
		datao : out std_ulogic_vector(15 downto 0) 
	);
end LUT_UN_SIN_32x16;

architecture lut_arch of LUT_UN_SIN_32x16 is

	component multiplexer is
		generic ( 
			N: integer := 4
		);
		
		port (
				sel: in std_ulogic;
				opt1: in std_ulogic_vector(N-1 downto 0);
				opt2: in std_ulogic_vector(N-1 downto 0);
				output: out std_ulogic_vector(N-1 downto 0)
		);
	end component multiplexer;

	type LUT_t is array (natural range 0 to 31) of std_ulogic_vector(15 downto 0);
	constant LUT: LUT_t := (
		0	 =>	 "1000000000000000",
		1	 =>	 "1000011001000111",
		2	 =>	 "1000110010001011",
		3	 =>	 "1001001011000111",
		4	 =>	 "1001100011111000",
		5	 =>	 "1001111100011001",
		6	 =>	 "1010010100100111",
		7	 =>	 "1010101100011111",
		8	 =>	 "1011000011111011",
		9	 =>	 "1011011010111001",
		10	 =>	 "1011110001010110",
		11	 =>	 "1100000111001101",
		12	 =>	 "1100011100011100",
		13	 =>	 "1100110000111111",
		14	 =>	 "1101000100110011",
		15	 =>	 "1101010111110101",
		16	 =>	 "1101101010000010",
		17	 =>	 "1101111011010111",
		18	 =>	 "1110001011110001",
		19	 =>	 "1110011011001111",
		20	 =>	 "1110101001101101",
		21	 =>	 "1110110111001001",
		22	 =>	 "1111000011100010",
		23	 =>	 "1111001110110101",
		24	 =>	 "1111011001000001",
		25	 =>	 "1111100010000100",
		26	 =>	 "1111101001111100",
		27	 =>	 "1111110000101001",
		28	 =>	 "1111110110001001",
		29	 =>	 "1111111010011100",
		30	 =>	 "1111111101100001",
		31	 =>	 "1111111111011000"
	); 
  
	signal notphase : std_ulogic_vector(4 downto 0);  
	signal outmul1 : std_ulogic_vector(4 downto 0);	
	signal outmul1_u : unsigned (4 downto 0);	
	signal inmul2: std_ulogic_vector(15 downto 0);
	signal notinmul2: std_ulogic_vector(15 downto 0);  
	signal outmul2 : std_ulogic_vector(15 downto 0);

	begin	

		notphase <= not phase(4 downto 0);
		
		Imul1: 
			multiplexer generic map (N=>5)
				port map (sel => phase(5), opt1 => notphase, opt2 => phase(4 downto 0), output => outmul1);	
	
		outmul1_u <= unsigned(outmul1);
		inmul2 <= LUT(to_integer(outmul1_u));	
		
		notinmul2 <= not inmul2; 
		Imul2: 
			multiplexer generic map (N=>16)
				port map (sel => phase(6), opt1 => notinmul2, opt2 => inmul2, output => outmul2);
	
		datao <= outmul2;

end lut_arch;