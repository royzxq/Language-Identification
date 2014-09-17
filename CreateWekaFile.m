
function  CreateWekaFile(train1,train2)

window = [];
label = [];
file = fopen('VocalLanguage_long.arff','w');

fprintf(file,'@RELATION vocalLanguage\n');
for i = 1:62
    s = ['feature',num2str(i)];
    fprintf(file,'@ATTRIBUTE %s NUMERIC\n',s);
end

fprintf(file,'@ATTRIBUTE class {1,2} \n');
fprintf(file,'@DATA\n');

for i = 1:length(train1)
    len = size(train1{i},2);
    
    if len < 200
        blocksize = 100;
        hopsize = 50;
    else 
        blocksize = 200;
        hopsize = 50 ;
    end
    
    for j = 1:hopsize:len
        if j + blocksize <= len
            data = train1{i}(:,j:j+blocksize);
            feature = mean(data,2)';
            for k = 1:length(feature)
                fprintf(file,'%f,',feature(k));
            end
            fprintf(file,'1\n');
        end
    end
    
end

for i = 1:length(train2)
    len = size(train2{i},2);
    if len < 200
        blocksize = 100;
        hopsize = 50;
    else 
        blocksize = 200;
        hopsize = 50 ;
    end
    for j = 1:hopsize:len
        if j + blocksize <= len
            data = train2{i}(:,j:j+blocksize);
            feature = mean(data,2)';
            for k = 1:length(feature)
                fprintf(file,'%f,',feature(k));
            end
            fprintf(file,'2\n');
        end
    end
    
end

%{
window = [];
label = [];

for i = 1:length(train2)
    len = length(train2{i});
    for j = 1:20:len
        if j + 40 < len
            data = train2{i}(:,j:j+40);
            feature = mean(data,2)';
            label = [label;2.0];
            window = [window;feature];
        end
    end
    
end

[r,c] = size(window);
for i = 1:r
    for j = 1:c
        fprintf(file,'%f,',window(i,j));
    end
    fprintf(file,'%d\n',label(i));
end
%}
fclose(file);
end
