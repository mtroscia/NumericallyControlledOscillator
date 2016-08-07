function [] = lut_un_sin_MxP(M, P)

	for i=1:2^M
		k(i) = i-1;
	end

	in = sin(k*2*pi/2^M);
	LSB = 2/(2^P-1);
	out = round((1+in)/LSB);
	out_bin = dec2bin(out, P);

	name = ['lut_un_sin_' int2str(2^M) 'x' int2str(P) '.txt'];
	fileID = fopen(name, 'w');
	for i=1:2^M
		fprintf(fileID, '%d\t =>\t "%s"', k(i), out_bin(i, :));
		if (i~=2^M)
			fprintf(fileID, ',\n');
		end
	end
	fclose(fileID);
	
end