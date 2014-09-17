load feature_chinese;

Q = 32;
M = 4 ; 
O = 13;

prior0 = ones(Q,1)/Q;
transmat0 = ones(Q,Q)/Q;

len = length(feature_chinese);


    %[mu0, Sigma0] = mixgauss_init(M*Q, feature_chinese, 'diag','kmeans');

    %mu0 = reshape(mu0, [O Q M]);
    %Sigma0 = reshape(Sigma0, [O O Q M]);
[r,c,w] = size(sigma);
one = ones(1,r);
dia= diag(one);

for i = 1:w
    sigma(:,:,i) = sigma(:,:,i).*dia;
end

for i = 1:M
    mu0(:,:,i) = C';
    Sigma0(:,:,:,i) = sigma;
end

mixmat0 = mk_stochastic(rand(Q,M));

[LL, prior1, transmat1, mu1, Sigma1, mixmat1] = ...
mhmm_em(feature_chinese, prior0, transmat0, mu0, Sigma0, mixmat0, 'max_iter', 6);

l = mhmm_logprob(feature_chinese, prior1, transmat1, mu1, Sigma1, mixmat1);


