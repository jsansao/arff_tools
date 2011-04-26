function csv_to_arff(filein, fileout)
% Reads csv file and outputs arff file 
% usage:
%
%       output = csv_to_arff(filein, fileout)

[fid, MESSAGE] = fopen(filein);

tline = fgets(fid);

if strfind(tline, 'filename')
    NumCommas = length(strfind(tline, ','));
else
    error('file must start with filename');
end


buffer = strread(tline, '%s', NumCommas+1, 'delimiter',',');
attributes = buffer(1:end);
N_attributes = length(attributes);



fid2 = fopen(fileout, 'w');


fprintf(fid2, '@relation imported_csv\n')
fprintf(fid2, '\n');


fprintf(fid2, '@attribute %s string\n', attributes{1});

for I = 2 : N_attributes
    fprintf(fid2, '@attribute %s numeric\n', attributes{I});
end

fprintf(fid2, '\n');
fprintf(fid2, '@data\n')
fprintf(fid2, '\n');


while ~(feof(fid))
    tline = fgets(fid);
    fprintf(fid2, '%s\n', tline);
end

fclose(fid);
fclose(fid2);
