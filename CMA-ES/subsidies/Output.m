function O = Output(j, inp)
%  computes output of NN P(j)
%

global NN

% Get hidden layer node outputs
W= [NN(j,1:6); NN(j,7:12); NN(j,13:18); NN(j,19:24); NN(j,25:30)];
H= W*inp';

% run hidden layer outputs through activation function
y= [AF(H(1)) AF(H(2)) AF(H(3)) AF(H(4)) AF(H(5))];

% get output node output
W= [NN(j,31:35)];
% run thru activation function
h = AF(W*y');
% map onto unit interval
O= (h+1)/2.;

end
