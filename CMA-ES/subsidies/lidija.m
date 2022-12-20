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

fptr= fopen('lidija2.txt','w');

NN(1,:)= LAST(1,:); % NNs in tournament
NN(2,:)= LAST(2,:);
NN(3,:)= LAST(3,:);
bids= Tournament();
s= norm(bids,1);
fprintf(fptr,'(top 3)  %.3f\t%.3f\t%.3f\t\t%.3f\n\n',bids(1),bids(2),bids(3),s);

fprintf(fptr,'1 & 2\n');
for k=4:6
    NN(3,:)= LAST(k,:);
  
        bids= Tournament();
    
    fprintf(1,'CNTR 1,2= %d\n',CNTR);
    h(k)= norm(bids,1);
    fprintf(fptr,'h(%d)= %.3f\t%.3f\t%.3f\t%.3f\n',k,h(k),bids(1),bids(2),bids(3));
end

fprintf(fptr,'1 & 3\n');

NN(2,:) = LAST(3,:);
for k=4:6
    NN(3,:)= LAST(k,:);
    bids= Tournament();
    
    fprintf(1,'CNTR 1,3= %d\n',CNTR);
    m(k)= norm(bids,1);
        fprintf(fptr,'h(%d)= %.3f\t%.3f\t%.3f\t%.3f\n',k,m(k),bids(1),bids(2),bids(3));

end

fprintf(fptr,'2 & 3\n');

NN(1,:) = LAST(2,:);
for k=4:6
    NN(3,:)= LAST(k,:);
    bids= Tournament();
    fprintf(1,'CNTR 2,3= %d\n',CNTR);
    
    n(k)= norm(bids,1);
        fprintf(fptr,'h(%d)= %.3f\t%.3f\t%.3f\t%.3f\n',k,n(k),bids(1),bids(2),bids(3));

end

% dcombined= [h(:), m(:), n(:)];
% hb= bar(x, dcombined, 'grouped');
% dist=1;
% 
% xlim([3.5 6.5]);
% ylim([0 1.2]);
% set(hb(1), 'FaceColor','[0, 0.4460, 0.641]');  % NN 1&2
% set(hb(2), 'FaceColor', '[0.85, 0.425, 0.098]'); % NN 1 & 3
% %set(hb(3), 'FaceColor', '[0.455, 0.664, 0.188]'); % NN 2 & 3
% set(hb(3), 'FaceColor', '[0.635, 0.079, 0.1840]'); % NN 2 & 3
% 
% set(hb(1), 'BarWidth', 0.49);
% set(hb(2), 'BarWidth', 0.49);
% set(hb(3), 'BarWidth', 0.49);
% 
% hold on
% a(1)=3.5;
% a(2)=6.5;
% b(1)= 1.15;
% b(2)= 1.15;
% 
% plot(a,b,'--k', 'LineWidth', 2.2);

Y= [h(4:6)'; m(4:6)'; n(4:6)'];
X= 4:6;
hb= bar(X,Y,1);
xlim([3.5 6.5]);
ylim([0 1.2]);
set(hb(1), 'FaceColor','[0, 0.4460, 0.641]');  % NN 1&2
set(hb(2), 'FaceColor', '[0.455, 0.664, 0.188]'); % NN 2 & 3
%set(hb(3), 'FaceColor', '[0.635, 0.079, 0.1840]'); % NN 2 & 3
set(hb(3), 'FaceColor', '[0.85, 0.425, 0.098]'); % NN 1 & 3

hold on
a(1)=3.5;
a(2)=6.5;
b(1)= 1.15;
b(2)= 1.15;

plot(a,b,'r:', 'LineWidth', 2.2);



fclose(fptr );

