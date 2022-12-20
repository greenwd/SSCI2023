% this script returns results of a 15-round
% tournament of the indicated NNs
clc

global NN
global CNTR

M=6;
x= 1:6;
h= zeros(6,1);
m= zeros(6,1);
n= zeros(6,1);

r1 = 0.33;
r2 = 0.33;
r3 = 0.33;
r4 = 0.33;

fptr= fopen('lidija22.txt','w');

NN(1,:)= LAST(1,:); % NNs in tournament
NN(2,:)= LAST(2,:);
NN(3,:)= LAST(3,:);
bids= Tournament2(fptr,r1,r2,r3,r4);
s= norm(bids,1);
fprintf('NN1: %.3f\tNN2: %.3f\tNN3: %.3f\tbid total: %.3f\n',...
    bids(1),bids(2),bids(3),s);

fclose(fptr );

