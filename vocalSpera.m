function [Vocal Background V B W] = vocalSpera(x,pvalue,uvalue)%alph)
%----vocal separation using KNN and median filter----%

fname = x;
X = wavread(fname);


%calculate the STFT of the mix file%
windowLength  = 4096;
hopSize = 1024;
Scomplex = mySTFT(X,windowLength,hopSize);
S = abs(Scomplex);

% % % %--using HPSS for pre-processing%
% % % [H P] = myHPSS(Scomplex,50,0.3,0.3);
% % % S = abs(H);

%calculate the Mahalanobis distence between frames%
[M N] = size(S);
% STD = std(S,0,2);
% Sstd = zeros(M,N);
% for k = 1:N
%    Sstd(:,k) = S(:,k)./STD; 
% end
D = zeros(N,N);
for i = 1: N
    for j = 1: N
        D(i,j) = (S(:,i)-S(:,j))'*(S(:,i)-S(:,j));
    end
end

%find the first p nearest frames%
[SortD IX] = sort(D,2);
pNearest = pvalue;
PIndex = IX(:,1:pNearest);

%do the median operation%
PM = zeros(M,pNearest);
Y = zeros(M,N);
Yk = zeros(M,1);
count = 1;
for i = 1: N
    PM = S(:,PIndex(i,1:pNearest));  
    Yk = median(PM,2);
    Y(:,count) = Yk;
    count = count +1;
end

%generate the soft mask based on Gaussian RBF%
W = zeros(M,N);
u = uvalue;
for i = 1:N
    for j = 1:M
        W(j,i) = exp(log(S(j,i)/(Y(j,i)+0.0001))*log(S(j,i)/(Y(j,i)+0.0001))/(-2*u*u));
    end
end

%post-process the W matrix%
W(1:10,:) = 1;
W(700:end,:) = 1;
% npoint = 10;
% smooth_win = ones(1,npoint)';
% for i = 1:N
%     n = 1;
%     while(n<M-npoint)
%        W(n,i) =  mean(W(n:n+npoint-1,i).*smooth_win);
%        n = n+5;
%     end
% end


%calculate the spectrogram of background music and vocal%
B = W.*Scomplex;
V = (ones(M,N)-W).*Scomplex;

%convert the B & V into audio%
Background = myistft(B,windowLength,hopSize);
Vocal = myistft(V,windowLength,hopSize);