% processes audio files to compute their envelope and peak rate information
% using the find_peakRate function. It then creates a Praat TextGrid for peakRates.

% @cz, May 2024

%%
addpath('C:\Users\Camille\OneDrive\Vaca_y_Pollito_Clari\Annotations\mPraat-master');

%% Load data

% Load the envelope data for "pollo"
load('./envolventes/envolvente_pollo_bip_loudness_128.mat');


% Initialize an empty array to hold peak rate times and magnitudes
pRateTime = [];
pRateMagn = [];

% Find peak rate time points
for i = 1:length(envolvente)
    datos = envolvente(i);
    time = datos.tps ./ datos.soundFs;
    mint = min(time);
    maxt = max(time);
    time = linspace(mint, maxt, length(datos.peakRate));
    npr = datos.peakRate > 0;
    ix = time(npr);
    ixx = datos.peakRate(npr);
    pRateTime = [pRateTime, ix];
    pRateMagn = [pRateMagn, ixx];
end

% Scale up the magnitude so it is easier to see on Praat
scaleFactor = 100;
pRateMagn = pRateMagn*scaleFactor;

% Read the existing TextGrid file
tg = tgRead('./Annotations/pollo/polloconcatenado_bip_mfa.TextGrid');

% Create a new TextGrid object
tgNew = tgCreateNewTextGrid(tg.tmin, tg.tmax);

% Insert a new tier for peak rates
tgNew = tgInsertNewPointTier(tgNew, 1, 'peakRates');

% Insert peak rate points into the new tier
for i = 1:length(pRateTime)
    tgNew = tgInsertPoint(tgNew, 1, pRateTime(i),num2str(pRateMagn(i),3)) ;
end

% Write the new TextGrid file (uncomment the line below to save the file)
tgWrite(tgNew, './Annotations/pollo/polloconcatenado_bip_pRates_Mag.TextGrid', 'short');

