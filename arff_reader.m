function output = arff_reader(filename)
% Reads arff file and outputs cell with content 
% usage:
%
%       output = arff_reader(filename)

[fid, MESSAGE] = fopen(filename);

tline = fgets(fid);
attribute =[];
values = [];
class_attribute =[];

% reading header until @data appears
while ischar(tline)
    if strfind(tline, '@relation')
        %copies relation name output.relation
        buffer = strread(tline, '%s', 2);
        relation = buffer(2);
    elseif strfind(tline, '@attribute')
        %add attribute  output.atribute
        % verifies if string or numeric
        buffer = strread(tline, '%s', 3);
        attribute =[attribute; buffer(2)];
        if strfind(tline, 'numeric')
            class_attribute = [class_attribute; 1];
        else
            class_attribute = [class_attribute; 0];
        end
    elseif strfind(tline, '@data')
        break;
    end
    tline = fgets(fid);
end

tline = fgets(fid);
while ischar(tline)
    if (length(tline)>1)
        buffer = strread(tline,'%s', length(attribute), 'delimiter', ...
                         ',');
        for I = 1: length(attribute)
            if class_attribute(I)
                temp_buf = buffer{I};
                new_buffer{I} = str2num(temp_buf);
            else
                new_buffer{I} = buffer{I};
            end

        end

        values = [values;  new_buffer];
    end
    tline = fgets(fid);
end


output.values = values;
output.attribute = attribute;
output.class_attributes = class_attribute; 
fclose(fid);





