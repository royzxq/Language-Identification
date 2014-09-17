function English_vocal = preprocessing(fileDir)
filelist = getAllFiles(fileDir);

k = 1;

for i = 1:length(filelist)
    [a,b,c] = fileparts(filelist{i});
    if ~strcmp(c,'.wav')
        continue;
    end
    [wav,fs] = wavread(filelist{i});
    if size(wav,2)>1
        %single = (wav(:,1)+wav(:,2))/2;
        single = wav(:,2);
    else
         single = wav; 
    end
    if length(wav)<5*fs
        continue;
    end
    
    %single = (stereo(:,1)+stereo(:,2))/2;
    [wav] = vadsohn(wav,fs);
    wav(wav(:)==0) = [];
    Tw = 50;           % analysis frame duration (ms)
    Ts = 25;           % analysis frame shift (ms)
    alpha = 0.97;      % preemphasis coefficient
    R = [ 300 3700 ];  % frequency range to consider
    M = 20;            % number of filterbank channels 
    C = 13;            % number of cepstral coefficients
    L = 22;            % cepstral sine lifter paramete
    hamming = @(N)(0.54-0.46*cos(2*pi*[0:N-1].'/(N-1)));
    [ MFCCs, FBEs, frames ] = ...
                            mfcc( single, fs, Tw, Ts, alpha, hamming, R, M, C, L );
    MFCCs(isnan(MFCCs)) = 0;
    SDCs = SDC(MFCCs);
    features = [MFCCs(:,2:end-19);SDCs];
    English_vocal{k} = features;
    
    k = k + 1;
end
save /Users/xinquanzhou/Desktop/Data/English_vocal English_vocal;

end
