% this script creates the database from which
% the Shapley values will be computed.

clc

global NN

%global CNTR

rand(2);
M=6;
x= 1:6;
h= zeros(6,1);
m= zeros(6,1);
n= zeros(6,1);
AMY= [0.3472 0.3416 0.5000 0.3472 0.3416 0.5000 0.3471 ... 
    0.3416 0.5000 0.3471 0.3416 0.5000 0.3471 0.3472   ...
    0.5000 0.3471 0.3472 0.5000 1.0359];

r1 = 0.33;
r2 = 0.33;
r3 = 0.33;
r4 = 0.33;

fptr= fopen('lidija22.txt','w');

NN(1,:)= LAST(1,:); % NNs in tournament
NN(2,:)= LAST(2,:);
NN(3,:)= LAST(3,:);

for I=1:5
%    [bids, A]= Tournament22(fptr );
    A= verify2(fptr );
    AMY = vertcat(AMY, A);
    fprintf(fptr,'\n');
end

% *.csv file creation
writematrix(AMY,'lidija.csv');

s= sum(bids );
fprintf('NN1: %.3f\nNN2: %.3f\nNN3: %.3f\nbid total: %.3f\n',...
    bids(1),bids(2),bids(3),s);

fclose(fptr );

