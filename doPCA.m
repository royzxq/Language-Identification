clear all;
addpath('/Users/xinquanzhou/Desktop/Data');

load Chinese_norm;

len = length(Chinese);
data = [];

for i = 1:len
    L = length(Chinese{i});
    idx = randperm(L);
    idx = idx(1:round(L/10));
    idx = sort(idx);
    data = [data,Chinese{i}(:,idx)];
end

clear Chinese;

load English_norm;


len = length(English);

for i = 1:len
    L = length(English{i});
    idx = randperm(L);
    idx = idx(1:round(L/10));
    idx = sort(idx);
    data = [data,English{i}(:,idx)];
end
clear English;

con = pca(data');

save pca con;



