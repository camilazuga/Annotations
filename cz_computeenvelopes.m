% uses Oganians find_peakrate function to compute envelopes
% critical parameters are envtype and envfs
% need to manually change dir in arch
% output is a struct called envolvente with the function output plus parameters, saved as a
% mat file
% @cz, Jan 2024

% Add necessary paths to the mPraat toolbox
% (https://github.com/bbTomas/mPraat)

addpath('C:\Users\Camille\OneDrive\Vaca_y_Pollito_Clari\Annotations\mPraat-master');

%% Load and Process Audio Files

% List of audio files in the directory
arch = dir('./Annotations/vaca/*.wav');

% Initialize an empty struct to hold envelope data
envolvente = struct();

% Loop through each audio file in the directory
for j =  1:length(arch)
    % Construct the full filename and read the audio
    filename = strcat(arch(j).folder, '\', arch(j).name);
    [audio, originalFs] = audioread(filename);
    disp(arch(j).name)

    % Define the range of the audio to be processed
    ini = 1;
    fin = floor(length(audio) / originalFs) * originalFs;
    sound = audio(ini:fin, 1);
    soundfs = originalFs;

    % Set parameters for envelope calculation
    onsOff = [];
    envtype = 'loudness';
    envfs = 256 / 2;

    % Shorten the files for memory efficiency
    n = 0:(length(sound) / 10):length(sound);
    n(end) = n(end) - 1; % Adjust the last segment

    % Process each segment of the audio file
    for i = 1:length(n) - 1
        disp(['Processing segment: ', num2str(i)])
        
        % Assign metadata to the struct
        envolvente(i).envtype = envtype;
        envolvente(i).envfs = envfs;
        envolvente(i).audio = arch(j).name;

        % Extract the current segment of the audio
        shortsound = sound(n(i) + 1:n(i + 1));

        % Compute the envelope and peak rate for the segment
        [envolvente(i).env, envolvente(i).peakRate, envolvente(i).peakEnv] = find_peakRate(shortsound, soundfs, onsOff, envtype, envfs);

        % Assign time points and original sampling frequency
        envolvente(i).tps = n(i) + 1:n(i + 1);
        envolvente(i).soundFs = originalFs;
    end
    
    % Save the envelope data to a .mat file
    save("./envolventes/envolvente_pollo_bip_" + envtype + "_" + envfs + ".mat", 'envolvente', '-append');

end
