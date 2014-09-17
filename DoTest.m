function acc = DoTest(test,true,LL1, prior1, transmat1, mu1, Sigma1, mixmat1,LL2, prior2, transmat2, mu2, Sigma2, mixmat2)

len = length(test);
cor = 0 ;
for i = 1:len
   loglik1 = mhmm_logprob(test{i}, prior1, transmat1, mu1, Sigma1, mixmat1);
   loglik2 = mhmm_logprob(test{i}, prior2, transmat2, mu2, Sigma2, mixmat2);
   if loglik1>loglik2
       label = 1;
   else
       label = 2;
   end
   if label == true
       cor = cor + 1;
   end
end

acc = cor/len;

end
