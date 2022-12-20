function g = AF(n)
%  this is actually a tanh() function which
% is a scaled sigmoid function
%

g = (2. / (1 + exp(-5.0*n)))-1.0;
end
