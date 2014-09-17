function [LL, prior1, transmat1, mu1, Sigma1, mixmat1] = trainHMM(data,M,Q)

% M is the number of Gaussian, O is the number of dimensions, Q is the number of states 
training = [];

for i = 1:length(data)
    training = [training,data{i}];
end
O = size(training,1);
[idx,C] = kmeans(training',Q);

sigma = zeros(O,O,Q);
for i = 1:Q
    id = find(idx==i);
    tmp = training(:,id);   
    a = cov(tmp');
    sigma(:,:,i) = cov(tmp');
end

prior0 = ones(Q,1)/Q;
transmat0 = ones(Q,Q)/Q;

one = ones(1,O);
dia= diag(one);

for i = 1:Q
    sigma(:,:,i) = awgn(sigma(:,:,i),20).*dia;
end

for i = 1:M
    mu0(:,:,i) = awgn(C',20);
    Sigma0(:,:,:,i) = sigma;
end
mixmat0 = mk_stochastic(rand(Q,M));

[LL, prior1, transmat1, mu1, Sigma1, mixmat1] = ...
mhmm_em(data, prior0, transmat0, mu0, Sigma0, mixmat0, 'max_iter', 5);

end