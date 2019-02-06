clear all;
close all;

[s1, sr1] = audioread('speech1.wav');
[s2, sr2] = audioread('speech2.wav');

[result1, result2] = chim_synth(s1, s2);

audiowrite('chimera1.wav', result1, sr1);
audiowrite('chimera2.wav', result2, sr1);