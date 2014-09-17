function testSP(filepath)

%% addpath

addpath('bss_eval');
addpath(genpath('inexact_alm_rpca'));


%% 
filenames = getAllFiles(filepath);

for i = 1:length(filenames)    
    filename = filenames{i};
    [a,b,c] = fileparts(filename);
    if ~strcmp(c,'.wav')
        continue;
    end
    [wavinmix,Fs]= wavread(filename);

    %% Run RPCA
    parm.outname=['output' filesep 'output' filesep num2str(i),c];
    parm.lambda=1;
    parm.nFFT=1024;
    parm.windowsize=1024;
    parm.masktype=1; %1: binary mask, 2: no mask
    parm.gain=1;
    parm.power=1;
    parm.fs=Fs;

    Parms=SP(wavinmix,parm); % SDR(\hat(v),v),                    

end

end