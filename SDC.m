function sdc = SDC(mfcc)
% just calculate the SDC coefficients by using 7-1-3-7
[r,c] = size(mfcc);
if r < 7 
    return;
end

sdc = [];

for i = 1:c
    if i+6*3+1>c
        break;
    end
    if i-1<1
        continue;
    end
    sdc_tmp = [];
    for j = 0:6
        tmp = mfcc(1:7,i+3*j+1)-mfcc(1:7,i+3*j-1);
        sdc_tmp = [sdc_tmp;tmp];
    end
    sdc = [sdc,sdc_tmp];
end
end       
