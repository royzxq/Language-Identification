function data = DoNorm(data)

len = length(data);
[m,StD] = preNorm(data);
dimension = size(data{1},1);
for i = 1:len
    for j = 1:dimension
        data{i}(j,:) = (data{i}(j,:)-m(j))/StD(j);
    end
end

end