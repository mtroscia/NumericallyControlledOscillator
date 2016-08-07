#include<iostream>
#include<cstdlib>
#include<bitset>
#include<string>
using namespace std;

int main()
{
	unsigned short frequency, phase, amplitude;
	unsigned short num_cycles;
	unsigned short counter = 0;
	
	cout << "Enter the frequency: ";
	cin >> frequency;
	cout << endl << "Enter the phase: ";
	cin >> phase;
	cout << endl << "Enter the amplitude: ";
	cin >> amplitude;
	cout << endl << "Enter the number of clock cycles: ";
	cin >> num_cycles;
	
	for (int i=0; i<=num_cycles-2; i++)
	{
		counter += frequency;
		
		unsigned short inlut = counter+phase;
		
		std::bitset<16> inlut_bit(inlut);
		std::bitset<2> MSB;
		
		//set bits used for controls
		MSB[0]=inlut_bit[14];
		MSB[1]=inlut_bit[15];
		if (MSB[0]==1)
		{
			inlut_bit = ~inlut_bit;
		}
		
		std::bitset<5> inlut_bit_tr;
		for (int j=0; j<5; j++)
			inlut_bit_tr[j] = inlut_bit[9+j];			
		int inlut_tr = inlut_bit_tr.to_ulong();
		
		unsigned short outlut;
		switch(inlut_tr)
		{
			case 0:
				outlut = 32768; 
				break;
			case 1:
				outlut = 34375;
				break;
			case 2:
				outlut = 35979;
				break;
			case 3: 
				outlut = 37575;
				break;
			case 4:
				outlut = 39160;
				break;
			case 5:
				outlut = 40729;
				break;
			case 6:
				outlut = 42279;
				break;
			case 7:
				outlut = 43807;
				break;
			case 8:
				outlut = 45307;
				break;
			case 9:
				outlut = 46777;
				break;
			case 10:
				outlut = 48214;
				break;
			case 11:
				outlut = 49613;
				break;
			case 12:
				outlut = 50972;
				break;
			case 13: 
				outlut = 52287;
				break;
			case 14:
				outlut = 53555;
				break;
			case 15:
				outlut = 54773;
				break;
			case 16:
				outlut = 55938;
				break;
			case 17:
				outlut = 57047;
				break;
			case 18:
				outlut = 58097;
				break;
			case 19:
				outlut = 59087;
				break;
			case 20:
				outlut = 60013;
				break;
			case 21:
				outlut = 60873;
				break;
			case 22:
				outlut = 61666;
				break;
			case 23: 
				outlut = 62389;
				break;
			case 24:
				outlut = 63041;
				break;
			case 25:
				outlut = 63620;
				break;
			case 26:
				outlut = 64124;
				break;
			case 27:
				outlut = 64553;
				break;
			case 28:
				outlut = 64905;
				break;
			case 29:
				outlut = 65180;
				break;
			case 30:
				outlut = 65377;
				break;
			case 31:
				outlut = 65496;
				break;
		}

		std::bitset<16> outlut_bit (outlut);
		if (MSB[1]==1)
			outlut_bit = ~outlut_bit;
		unsigned int out = outlut_bit.to_ulong();

		out *= amplitude;
		
		//print out the output value
		cout << endl << "[cycle=" << i+2 << "] output=" << out << endl;		
	}
	
	char c;
	cout << endl << "Press a key to continue... ";
	cin >> c;
	return 0;
}