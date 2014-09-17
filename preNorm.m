function [m,StD] = preNorm(data)

len = length(data);

dimension = size(data{1},1);
m = zeros(1,dimension);
StD = zeros(1,dimension);
for j = 1:dimension
    d = [];
    for i = 1: len
        d = [d,data{i}(j,:)];
    end
    [m(j),StD(j)] = nor(d);
end

end
