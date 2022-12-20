function y = verify(l,m)
%
%

global CNTR
global radius

middle = [1/3 1/3 1/3];

fptr= fopen('nn.txt','w');
fprintf(fptr,'\n\nverifying NN 1, %d & %d\n\n',l,m);

pmax = 0.5;
pmin = 0.0;

cntr= zeros(15,1);

p= NaN(2,1);
x= NaN(3,6);
R= zeros(3,15);  % payoff during tournament
B= NaN(3,15);  % bids during tournament

%  first dummy input
%
x(1,:)= [0.33 0.33 pmax 0.33 0.33 pmax];
x(2,:)= x(1,:);
x(3,:)= x(1,:);

fprintf(fptr,' round 1\t inputs: \n');
fprintf(fptr,'I1, I2, I3: %.3f %.3f %.3f %.3f %.3f %.3f\n', ...
    x(1,1), x(1,2), x(1,3), x(1,4), x(1,5), x(1,6));
B11= Output(1,x(1,:));
B21= Output(2,x(2,:));
B31= Output(3,x(3,:));
fprintf(fptr,'outputs: %.3f %.3f %.3f\n',B11, B21, B31);
B(1,1) = B11;
B(2,1) = B21;
B(3,1) = B31;

L1 = [B11 B21 B31];
L2 = L1-middle;
L3 = norm(L1,1) <= 1;
L4 = norm(L2,1) <= radius;

if L3 || (~L3 && L4)
    %if norm([B11 B21 B31],1) <= 1
    p(1)= pmax;
    R(1,1)= B11;
    R(2,1)= B21;
    R(3,1)= B31;
else
    p(1)=pmin;
end

cntr(1) = 1;

% second dummy input
% x(1,:)= [y2 y3 yp B21 B31 p(1)];
% x(2,:)= [y1 y3 yp B11 B31 p(1)];
% x(3,:)= [y1 y2 yp B11 B21 p(1)];
x(1,:)= [0.33 0.33 pmax B21 B31 p(1)];
x(2,:)= [0.33 0.33 pmax B11 B31 p(1)];
x(3,:)= [0.33 0.33 pmax B11 B21 p(1)];

fprintf(fptr,' \nround 2\t inputs: \n');
fprintf(fptr,' I1: %.3f %.3f %.3f %.3f %.3f %.3f\n', ...
    x(1,1), x(1,2), x(1,3), x(1,4), x(1,5), x(1,6));
fprintf(fptr,' I2: %.3f %.3f %.3f %.3f %.3f %.3f\n', ...
    x(2,1), x(2,2), x(2,3), x(2,4), x(2,5), x(1,6));
fprintf(fptr,' I3: %.3f %.3f %.3f %.3f %.3f %.3f\n', ...
    x(3,1), x(3,2), x(3,3), x(3,4), x(3,5), x(1,6));
B12= Output(1,x(1,:));
B22= Output(2,x(2,:));
B32= Output(3,x(3,:));
fprintf(fptr,'outputs: %.3f %.3f %.3f\n',B12, B22, B32);

B(1,2) = B12;
B(2,2) = B22;
B(3,2) = B32;

L1 = [B12 B22 B32];
L2 = L1-middle;
L3 = norm(L1,1) <= 1;
L4 = norm(L2,1) <= radius;

if L3 || (~L3 && L4)
    %if norm([B12 B22 B32],1) <= 1
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
% fprintf(fptr,' I1: %.3f %.3f %.3f %.3f %.3f %.3f\n', ...
%     x(1,1), x(1,2), x(1,3), x(1,4), x(1,5), x(1,6));
% fprintf(fptr,' I2: %.3f %.3f %.3f %.3f %.3f %.3f\n', ...
%     x(2,1), x(2,2), x(2,3), x(2,4), x(2,5), x(2,6));
% fprintf(fptr,' I3: %.3f %.3f %.3f %.3f %.3f %.3f\n', ...
%     x(3,1), x(3,2), x(3,3), x(3,4), x(3,5), x(3,6));
% now finish the rest of the tournament
for k=3:15
    fprintf(fptr,'\n round %d\t inputs: \n',k);
    fprintf(fptr,' I1: %.3f %.3f %.3f %.3f %.3f %.3f\n', ...
        x(1,1), x(1,2), x(1,3), x(1,4), x(1,5), x(1,6));
    fprintf(fptr,' I2: %.3f %.3f %.3f %.3f %.3f %.3f\n', ...
        x(2,1), x(2,2), x(2,3), x(2,4), x(2,5), x(2,6));
    fprintf(fptr,' I3: %.3f %.3f %.3f %.3f %.3f %.3f\n', ...
        x(3,1), x(3,2), x(3,3), x(3,4), x(3,5), x(3,6));
    O1= Output(1,x(1,:));
    O2= Output(2,x(2,:));
    O3= Output(3,x(3,:));
    B(1,k)= O1;
    B(2,k)= O2;
    B(3,k)= O3;
    fprintf(fptr,'outputs: %.3f %.3f %.3f\n',O1, O2, O3);
    
    L1 = [O1 O2 O3];
    L2 = L1-middle;
    L3 = norm(L1,1) <= 1;
    L4 = norm(L2,1) <= radius;
    
    if L3 || (~L3 && L4)
%        if norm([O1 O2 O3],1) <= 1
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
    end
    
    CNTR= numel(find(cntr(:) ~= 0));
    
    % return average payoffs
    
    fclose(fptr );
    
    R1= mean(R(1,:));
    R2= mean(R(2,:));
    R3= mean(R(3,:));
    y= [R1 R2 R3];
end

