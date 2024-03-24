function out_array = n_characters(string_array, n)
% n_characters takes in a list of strings, where each string represents one
% row of text, and a double n (that will be rounded to nearest integer).
% The out_array will then contain the first n'th characters.

tot = sum( cellfun(@numel, string_array));
characters = round(n*tot);
out_array = string_array;


remove = tot - characters;
row = height(string_array);
while true
if numel(out_array{row, 1}) > remove
break
end


remove = remove - numel(out_array{row, 1});

if 1 >= row
break
end

row = row -1;

end

out_array = out_array(1:row,1);

element = out_array{row,1};
out_array{row,1} = element(1:end-remove);

end