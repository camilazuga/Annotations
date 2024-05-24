% Loads pre-processed envelope data, reads the corresponding audio file, and plots the audio waveform, envelope, peak envelope, and peak rate. It is useful for visualizing how the envelope and peak rate correspond to the original audio signal.
% 
% Prerequisites
% Data File: Ensure the pre-processed envelope data file (.mat) is present in the specified directory.
% Audio Files: Ensure the audio files are located in the directory specified by direct.

% @cz, Jan 2024


%%
% Initialize the index for the envelope data
i = 1;

% Load the envelope data
load('./envolventes/envolvente_pollo_bip_loudness_128.mat');

% Directory containing the audio files
direct = './Annotations/pollo/';

% Construct the full filename for the audio file
filename = direct + "" + envolvente(i).audio;

% Read the audio file
[audio, originalFs] = audioread(filename);

% Set the window size for plotting
ventana = originalFs;
ini = 1;

% Extract envelope data for the selected index
env = envolvente(i).env;
envfs = envolvente(i).envfs;
envtype = envolvente(i).envtype;
peakEnv = envolvente(i).peakEnv;
peakRate = envolvente(i).peakRate;
name = envolvente(i).audio;

% Determine the end point for the envelope data
fin = length(env);

% Compute time vectors for plotting
time1 = (0:fin-1) / envfs;
durationinSecs = length(time1) / envfs;
time2 = originalFs * durationinSecs;

% Plot the audio waveform, envelope, peak envelope, and peak rate
figure;
plot((1:time2) / originalFs, audio(ini:ini + time2 - 1) * 0.5, 'LineWidth', 1.5, 'Color', [0.6 0.6 0.6]);
hold on;
plot(time1, env, 'LineWidth', 1.5);
plot(time1, peakEnv * 0.05, 'LineWidth', 1.5);
plot(time1, peakRate, 'LineWidth', 1.5);
legend('audio', 'envelope', 'peakenv', 'peakRate');
grid on;

% Construct the plot title using the audio file name and envelope type
nombre = name(1:end-4) + "-" + envtype + envfs;
title(nombre);
hold off;

% Save the figure (uncomment the line below to save the plot)
% savefig(strcat('./env figures/', nombre));

