# Annotations

This is a set of scripts to work with peakRates, audios and textGrids. Speacially aimed at visualization in matlab or Praat

1. cz_computeenvelopes.m computes the envelope based on Oganian´s findPeakRate function. It creates a structu with all necessary data for cz_createPeakRateTextGrid.m
2. cz_createPeakRateTextGrid.m loads the struct with the envelope (and additional info) and writes a Praat textGrid
3. cz_plotenvelopes is optional, to plot envelopes, peakRates, peakEnv and wavs in Matlab 
