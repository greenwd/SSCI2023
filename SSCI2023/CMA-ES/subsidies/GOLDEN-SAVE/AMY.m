clc
clear

global P
global NN
global NP
global D
global fit

initialize;   %  declarations & definitions

% temporary population
TP= NaN(NP,D);

LAST = NaN(NP,D);

% create indices for tournaments
v = 1:NP;
C = nchoosek(v,3);
LC = length(C);

% DE parameters
F = 0.85;  % scaling factor
CR= 0.7;  % xover rate
V= zeros(1,D);  % donor vector
U= zeros(1,D);  % trial vector
FIT= NaN(3,1);  % dummy array
G= 150;  % max number of generations

for g=1:G
    f= zeros(1,NP);
    
    for J=1:LC
        idx1= C(J,1);
        idx2= C(J,2);
        idx3= C(J,3);
        
        NN(1,:)= P(idx1,:); % NNs in tournament
        NN(2,:)= P(idx2,:);
        NN(3,:)= P(idx3,:);
        
        bids= Tournament();
        
        f(idx1) = f(idx1) + bids(1);
        f(idx2) = f(idx2) + bids(2);
        f(idx3) = f(idx3) + bids(3);
    end
    
    % average over all tournaments
    f = f/595.0;
    
    [fit, idx] = sort(f,'descend');
    
    for i=1:NP
        TP(i,:) = P(idx(i),:);
    end
    
    P= TP;
    
    % save pop for later analysis
    
    LAST= P;
    
    % use DE to get other 12 offspring
    
    for k=25:NP
        % create donor vector vector
        idx= randperm(24,3);
        r1= idx(1);
        r2= idx(2);
        r3= idx(3);
        % do mutation
        V= P(r1,:) + F.*(P(r2,:)-P(r3,:));
        
        % bound values between +/- 1
        for i=1:D
            if V(i) > 1.0    % bounce back
                V(i) = 1.0 - (V(i)-1.0);
            end
            if V(i) < -1.0
                V(i) = -1.0 + (-1.0 - V(i));
            end
%             V(i)= max(-1.0,V(i)); % clamp
%             V(i)= min(1.0,V(i));
        end
        
        % do xover
        jrand= randi(D,1);
        for j=1:D
            if rand()< CR || j==jrand
                U(j)= V(j);
            else
                U(j)= P(k,j);
            end
        end
        
        % compute fitness of trial vector
        L= randperm(24);
        NN(1,:)= U;  % trial vector
        NN(2,:)= P(k,:); %  target vector k
        NN(3,:)= P(L(2),:); % random vector
        bids= Tournament();
        [~, idx]= sort(bids,'descend');
        if idx(1)==1
            P(k,:)= U;
        elseif idx(2)==1 && idx(3)==2
            P(k,:)= U;
        else
            % keep P(k,:)
        end
    end
    clc
    fprintf(1,'%d\n',g);
end

% store LAST in .mat file 'myNN'.
% can get it back by executing
% at the prompt    load('myNN');
%
save('myNN','LAST');

