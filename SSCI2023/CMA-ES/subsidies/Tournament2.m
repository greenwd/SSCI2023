function y = Tournament2(fptr, r1,r2,r3,r4)
%
%

%global CNTR
global radius

cntr= zeros(15,1);

% center of hemisphere on 2-simplex
middle = [1/3 1/3 1/3]; 

p= NaN(2,1);
x= NaN(3,6);
R= zeros(3,15);  % payoff during tournament
B= NaN(3,15);  % bids during tournament

A= NaN(15,19);  % matrix to store inputs and prediction

pmax= 0.5;
pmin= 0.0;

%  first dummy input
%
x(1,:)= [r1 r2 pmax r3 r4 pmax];
x(2,:)= x(1,:);
x(3,:)= x(1,:);

B11= Output(1,x(1,:));
B21= Output(2,x(2,:));
B31= Output(3,x(3,:));
B(1,1) = B11;
B(2,1) = B21;
B(3,1) = B31;
S= B11+B21+B31;
A(1,:)= [r1 r2 pmax r3 r4 pmax r1 r2 pmax r3 r4 pmax r1 r2 ...
    pmax r3 r4 pmax S];
fprintf(fptr,'%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f\n',...
    A(1,:));
L1 = [B11 B21 B31];
L2 = L1-middle;
L3 = norm(L1,1) <= 1;
L4 = norm(L2,1) <= radius;

if L3 || (~L3 && L4)
    % if norm(L1,1) <= 1
    p(1)= pmax;
    R(1,1)= B11;
    R(2,1)= B21;
    R(3,1)= B31;
else
    p(1)=pmin;
end

cntr(1) = 1;

% second dummy input
x(1,:)= [r3 r4 pmax B21 B31 p(1)];
x(2,:)= [r3 r4 pmax B11 B31 p(1)];
x(3,:)= [r3 r4 pmax B11 B21 p(1)];

B12= Output(1,x(1,:));
B22= Output(2,x(2,:));
B32= Output(3,x(3,:));
B(1,2) = B12;
B(2,2) = B22;
B(3,2) = B32;
S= B12+B22+B32;
A(2,:)= [r3 r4 pmax B21 B31 p(1) r3 r4 pmax B11 B31 p(1)...
    r3 r4 pmax B11 B21 p(1) S];
fprintf(fptr,'%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f\n',...
    A(2,:));
L1 = [B12 B22 B32];
L2 = L1-middle;
L3 = norm(L1,1) <= 1;
L4 = norm(L2,1) <= radius;

if L3 || (~L3 && L4)
    % if norm(L1,1) <= 1
    p(2)= pmax;
    R(1,2)= B12;
    R(2,2)= B22;
    R(3,2)= B32;
else
    p(2)=pmin;
end

if p(2)
    cntr(2) = 1;
end

% inputs at start of tournament
x(1,:)=[B21 B31 p(1) B22 B32 p(2)];
x(2,:)=[B11 B31 p(1) B12 B32 p(2)];
x(3,:)=[B11 B21 p(1) B12 B22 p(2)];

% now finish the rest of the tournament
for k=3:15
    O1= Output(1,x(1,:));
    O2= Output(2,x(2,:));
    O3= Output(3,x(3,:));
    B(1,k)= O1;
    B(2,k)= O2;
    B(3,k)= O3;
    S= O1+O2+O3;
   
    
    L1 = [O1 O2 O3];
    L2 = L1-middle;
    L3 = norm(L1,1) <= 1;
    L4 = norm(L2,1) <= radius;
    
    if L3 || (~L3 && L4)
        pp= pmax;
        R(1,k)= O1;
        R(2,k)= O2;
        R(3,k)= O3;
        cntr(k) = 1;
    else
        pp=pmin;
    end
    % get next inputs
    p(1)= p(2);
    p(2)= pp;
    
    x(1,:)= [B(2,k-1) B(3,k-1) p(1) B(2,k) B(3,k) p(2)];
    x(2,:)= [B(1,k-1) B(3,k-1) p(1) B(1,k) B(3,k) p(2)];
    x(3,:)= [B(1,k-1) B(2,k-1) p(1) B(1,k) B(2,k) p(2)];
    
    A(k,:)= [B(2,k-1) B(3,k-1) p(1) B(2,k) B(3,k) p(2) ...
        B(1,k-1) B(3,k-1) p(1) B(1,k) B(3,k) p(2) ...
        B(1,k-1) B(2,k-1) p(1) B(1,k) B(2,k) p(2) S];
    fprintf(fptr,'%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f\n',...
    A(k,:));   

    if k==15
        famy=  fopen("explain_input.txt",'w');
        for j=1:19
            fprintf(famy,"%.4f ",A(k,j));
        end
        fclose(famy );
    end    
    
end

% *.csv file creation
writematrix(A,'lidija.csv');

CNTR= numel(find(cntr(:) ~= 0));

% return average payoffs
R1= mean(R(1,:));
R2= mean(R(2,:));
R3= mean(R(3,:));
y= [R1 R2 R3];
end

