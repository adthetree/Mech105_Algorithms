function [A] = specialMatrix(n,m)
% Inital conditions
n = input('number of rows: ');
m = input('number of columns: ');
specialMatrix(n,m)

% Calculations
A = zeros(n,m);
A(1,:) = 1:m;
A(:,1) = 1:n;

if nargin < 2
    error('not enough inputs')
elseif nargin == 2
    for i=2:n
        for j=2:m
            A(i,j) = A((i-1),j) + A(i,(j-1));
        end
    end
else nargin > 2
    error('too many inputs')
end
disp(A)
    
end

