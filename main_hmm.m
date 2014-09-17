%clear all;
warning off;
addpath('/Users/xinquanzhou/Desktop/Data');

%load English_original;
%load Chinese_original;



[acc1,acc2] = NflodCV(Chinese_original,English_original,5);

%[acc1_gmm,acc2_gmm] = NflodCV_GMM(Chinese,English,5);


%{
clear all;
load feature_chinese;
load feature_english;
load test_whole_chinese;
load test_whole_english;

Q = [4,8,16,32];
for i = 1:length(Q)
    [LL1, prior1, transmat1, mu1, Sigma1, mixmat1] = trainHMM(feature_chinese,Q(i));
    [LL2, prior2, transmat2, mu2, Sigma2, mixmat2] = trainHMM(feature_english,Q(i));

    acc1 = DoTest(test_chinese,1,LL1, prior1, transmat1, mu1, Sigma1, mixmat1,...
        LL2, prior2, transmat2, mu2, Sigma2, mixmat2)

    acc2 = DoTest(test_english,2,LL1, prior1, transmat1, mu1, Sigma1, mixmat1,...
        LL2, prior2, transmat2, mu2, Sigma2, mixmat2)
end


Q = [4,8,16,32];
for i = 1:length(Q)
    [LL1, prior1, transmat1, mu1, Sigma1, mixmat1] = trainHMM(test_chinese,Q(i));
    [LL2, prior2, transmat2, mu2, Sigma2, mixmat2] = trainHMM(test_english,Q(i));

    acc1 = DoTest(feature_chinese,1,LL1, prior1, transmat1, mu1, Sigma1, mixmat1,...
        LL2, prior2, transmat2, mu2, Sigma2, mixmat2)

    acc2 = DoTest(feature_english,2,LL1, prior1, transmat1, mu1, Sigma1, mixmat1,...
        LL2, prior2, transmat2, mu2, Sigma2, mixmat2)
end
%}