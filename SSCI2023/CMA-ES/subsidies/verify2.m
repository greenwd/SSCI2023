function B = verify2(fptr )
%
%

sigma= 0.2;

r1= 0.33 + sigma*randn();
r2= 0.33 + sigma*randn();
r3= 0.33 + sigma*randn();
r4= 0.33 + sigma*randn();
r5= 0.33 + sigma*randn();
r6= 0.33 + sigma*randn();


fprintf('r: %.3f\t%.3f\t%.3f\t%.3f\n',r1,r2,r3,r4);


p= NaN(2,1);
x= NaN(3,6);
R= zeros(3,15);  % payoff during tournament
B= NaN(1,19);  %  

A= NaN(1,19);  % matrix to store inputs and prediction

P11= 0.5;
P12= 0.5;

if rand() < 0.5
  P11= 0.0;
end

if rand() < 0.5
  P12= 0.0;
end


%  input to first NN
x(1,:)= [r1 r2 P11 r3 r4 P12];

P21= 0.5;
P22= 0.5;

if rand() < 0.5
  P21= 0.0;
end

if rand() < 0.5
  P22= 0.0;
end

%  input to second NN
x(2,:)= [r5 r6 P21 r1 r2 P22];

P31= 0.5;
P32= 0.5;

if rand() < 0.5
  P31= 0.0;
end

if rand() < 0.5
  P32= 0.0;
end

%  input to third NN
x(3,:)= [r5 r6 P31 r3 r4 P32];

B11= Output(1,x(1,:));
B21= Output(2,x(2,:));
B31= Output(3,x(3,:));
B(1,1) = B11;
B(2,1) = B21;
B(3,1) = B31;
S= B11+B21+B31;
A(1,:)= [r1 r2 P11 r3 r4 P12 r5 r6 P21 r1 r2 P22 r5 r6 ...
    P31 r3 r4 P32 S];
    
B(1,:)= A(1,:);
    
end

