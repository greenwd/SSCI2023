% this script creates the database from which
% the Shapley values will be computed.

clc

%% 
%% 
global NN

%global CNTR

AJ=3;

if AJ == 1
    rng(2);
elseif AJ == 2
    rng(49);
else
    rng(63);
end
       
M=6;
x= 1:6;
h= zeros(6,1);
m= zeros(6,1);
n= zeros(6,1);
fprintf('a: %.3f\tb= %.3f\n',rand(),rand());

AMY= [0.3472 0.3416 0.5000 0.3472 0.3416 0.5000 0.33];


fptr= fopen('lidija22.txt','w');

NN(1,:)= LAST(1,:); % NNs in tournament
NN(2,:)= LAST(2,:);
NN(3,:)= LAST(3,:);

for I=1:2000
%    [bids, A]= Tournament22(fptr );
    A= verify2(AJ );
    AMY = vertcat(AMY, A);
    fprintf(fptr,'\n');
end

% *.csv file creation
if AJ == 1
    writematrix(AMY,'lidija2-NN1.csv');
elseif AJ == 2    
    writematrix(AMY,'lidija2-NN2.csv');
else
    writematrix(AMY,'lidija2-NN3.csv');
end


    


s= sum(bids );
fprintf('NN1: %.3f\nNN2: %.3f\nNN3: %.3f\nbid total: %.3f\n',...
    bids(1),bids(2),bids(3),s);

fclose(fptr );

