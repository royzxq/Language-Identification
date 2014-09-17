load feature_chinese;
data = [];

for i = 1:length(feature_chinese)
    data = [data,feature_chinese{i}];
end

[idx] = kmeans(data',32);

cluster_amount = zeros(1,32);
cluster_dis = zeros(1,32);
for i = 1:length(idx)
    cluster_amount(idx(i)) = cluster_amount(idx(i)) + 1;
end

sigma = zeros(13,13,32);
for i = 1:32
    id = find(idx==i);
    tmp = data(:,id);
    sigma(:,:,i) = cov(tmp');
end
