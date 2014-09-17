function [Con,lamda]= pca(observation)

Con =  cov(observation); % calculate Convariance Matrix
[D,V] = eig(Con); % calculate the eigenvalue of each colume vector

[r,c] = size(observation);

for i = 1:c
    lamda(i) = V(i,i);
end
Con = D;

for i = 1:c %bubble sort by the decreasing eigenvalue 
    for j = 1:i
        if lamda(i)>lamda(j)
            swap = Con(:,i);
            Con(:,i) = Con(:,j);
            Con(:,j) = swap;
            s = lamda(i);
            lamda(i) = lamda(j);
            lamda(j) = s; 
        end
    end
end

plot(lamda);


end
