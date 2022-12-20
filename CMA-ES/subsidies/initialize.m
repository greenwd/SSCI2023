
clear
clc

global P
global NN  
global fit   % fitness array
global NP
global D

% initialize RNG
rng(2);

NP = 15;  % population size
D= 11;  % genome size

fit= zeros(1,NP);

% create population
 P = (1/sqrt(6))*randn(NP,D);

 NN= NaN(3,D);   % NN used for tournaments

