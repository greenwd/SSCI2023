function L = verify2(J, idx)
%
%

fptr1= fopen('subsidize.txt','a');
fptr2= fopen('coord.txt','a');
fptr3= fopen('uncoord.txt','a');


sigma= 0.07;
middle= [1/3 1/3 1/3];
radius= 0.05;

r1= abs(0.33 + sigma*randn()); % NN1 output at n-1 O11
r2= abs(0.33 + sigma*randn()); % NN2 output at n-1 O21
r3= abs(0.33 + sigma*randn()); % NN3 output at n-1 O31

r4= abs(0.33 + sigma*randn()); % NN1 output at n-2 O12
r5= abs(0.33 + sigma*randn()); % NN2 output at n-2 O22
r6= abs(0.33 + sigma*randn()); % NN3 output at n-2 O32


% P inputs for n-1
S1= r1+r2+r3;
if S1 <= 1.0
    P1= 0.5;
else
    P1= 0.0;
end

% P inputs for n-2
S1= r4+r5+r6;
if S1 <= 1.0
    P2= 0.5;
else
    P2= 0.0;
end


p= NaN(2,1);
x= NaN(3,6);
R= zeros(3,15);  % payoff during tournament
%L= NaN(1,19);  %  
L= NaN(1,7);
A= NaN(1,19);  % matrix to store inputs and prediction

%  input to first NN
x(1,:)= [r5 r6 P2 r2 r3 P1];

%  input to second NN
x(2,:)= [r4 r6 P2 r1 r3 P1];

%  input to third NN
x(3,:)= [r4 r5 P2 r1 r2 P1];

B1= Output(1,x(1,:));
B2= Output(2,x(2,:));
B3= Output(3,x(3,:));

%%%%%%%%%%%%%%%%%%%%%%
L1 = [B1 B2 B3];
L2 = L1-middle;
L3 = norm(L1,1) <= 1;
L4 = norm(L2,1) <= radius;

if L3 || (~L3 && L4)
    S= B1+B2+B3;
    if S > 1.0
        fprintf(fptr1, 'idx: %d\t%.3f\t%.3f\t%.3f\t%.3f\n',idx,B1,B2,B3,S);
    else
        fprintf(fptr2, 'idx: %d\t%.3f\t%.3f\t%.3f\t%.3f\n',idx,B1,B2,B3,S);
    end
else
    S=0.0;
    fprintf(fptr3, 'idx: %d\t%.3f\t%.3f\t%.3f\t%.3f\n',idx,B1,B2,B3,S);
end

fprintf('S= %.3f\n',S)

fclose(fptr1 );
fclose(fptr2 );
fclose(fptr3 );
%%%%%%%%%%%%%%%%%%


if J == 1
    T= [r5 r6 P2 r2 r3 P1 B1];
elseif J == 2
    T= [r4 r6 P2 r1 r3 P1 B2];
else
    T= [r4 r5 P2 r1 r2 P1 B3];
end

L(1,:)= round(T*10^3)/10^3;
    
end

