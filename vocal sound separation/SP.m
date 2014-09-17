function Parms=rpca_mask_fun(wavinmix,parm)
    %% parameters

    lambda = parm.lambda;
    nFFT = parm.nFFT;
    winsize = parm.windowsize;
    masktype = parm.masktype;
    gain = parm.gain;
    power = parm.power;
    Fs= parm.fs;
    outputname = parm.outname;

    hop = winsize/4;
    scf = 2/3;
    S = scf * stft(wavinmix, nFFT ,winsize, hop);

   %% use inexact_alm_rpca to run RPCA
    try                
        [A_mag E_mag] = inexact_alm_rpca(abs(S).^power',lambda/sqrt(max(size(S))));
        PHASE = angle(S');            
    catch err
        [A_mag E_mag] = inexact_alm_rpca(abs(S).^power,lambda/sqrt(max(size(S))));
        PHASE = angle(S);
    end
    
    A = A_mag.*exp(1i.*PHASE);
    E = E_mag.*exp(1i.*PHASE);

    %% binary mask, no mask
    switch masktype                         
      case 1 % binary mask + median filter
        m= double(abs(E)> (gain*abs(A)));                  
        try  
            Emask =m.*S;
            Amask= S-Emask;
        catch err
            Emask =m.*S';
            Amask= S'-Emask;
        end        
      case 2 % no mask
        Emask=E;
        Amask=A;
      otherwise 
          fprintf('masktype error\n');
    end

    %% do istft
    try 
        wavoutE = istft(Emask', nFFT ,winsize, hop)';   
    catch err
        wavoutE = istft(Emask, nFFT ,winsize, hop)';   
    end

    wavoutE=wavoutE/max(abs(wavoutE));
    wavwrite(wavoutE,Fs,outputname);


    
    Parms.SDR=0;
    Parms.SIR=0;
    Parms.SAR=0;
end
    
