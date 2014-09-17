function [accuracy1,accuracy2] = NflodCV(TS1,TS2,N)

len1 = length(TS1);
len2 = length(TS2);

if N~=1
   num1 = floor(len1/N);
   num2 = floor(len2/N);
   idx1 = randperm(len1);
   idx2 = randperm(len2);
   
   acc1 = zeros(1,N);
   acc2 = zeros(1,N);
   
   for i = 1:N
       Train1 = TS1;
       Train2 = TS2;
       
       testidx1 = idx1((i-1)*num1+1:i*num1);
       testidx2 = idx2((i-1)*num2+1:i*num2);
       
       test1 = TS1(testidx1);
       test2 = TS2(testidx2);
       
       Train1(testidx1) = [];
       Train2(testidx2) = [];
       
       
       M = 2; 
       [LL2, prior2, transmat2, mu2, Sigma2, mixmat2] = trainHMM(TS2,M,28);

       [LL1, prior1, transmat1, mu1, Sigma1, mixmat1] = trainHMM(TS1,M,32);
       
       acc1(i) = DoTest(test1,1,LL1, prior1, transmat1, mu1, Sigma1, mixmat1,...
            LL2, prior2, transmat2, mu2, Sigma2, mixmat2)

       acc2(i) = DoTest(test2,2,LL1, prior1, transmat1, mu1, Sigma1, mixmat1,...
            LL2, prior2, transmat2, mu2, Sigma2, mixmat2)
   end
   accuracy1 = mean(acc1);
   accuracy2 = mean(acc2);


end

end

