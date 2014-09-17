clear all;
addpath('/Users/xinquanzhou/Desktop/Data');

load pca;

load Chinese_norm;

len = length(Chinese);

for i = 1:len
    Chinese{i} = con(:,1:40)' * Chinese{i};
end
save /Users/xinquanzhou/Desktop/Data/Chinese_30 Chinese;

clear Chinese;

load English_norm;


len = length(English);

for i = 1:len
    English{i} = con(:,1:40)' * English{i};
end
save /Users/xinquanzhou/Desktop/Data/English_30 English;

clear English;
