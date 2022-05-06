function [L, U, P] = luFactor(A)
% luFactor(A)
%	LU decomposition with pivotiing
% inputs:
%	A = coefficient matrix
% outputs:
%	L = lower triangular matrix
%	U = upper triangular matrix
%       P = the permutation matrix

%% Function Setup
A = input('input coefficient matrix: ');
b = input('input output matrix: ');
if height(b) ~= length(a)
    error('dimensions of coefficient and output matrix are incompatable');
end
n = length(A);
L = zeros(n,n);
U = A;
P = eye (n,n);

%% Finding the Max entry
for i = 1:(n-1)
    [largest,j] = max(abs(U(i:n,i))); % Finds max entry in ith column
    j = j + (i - 1); % Offset
    if largest == 0
        error('Matrix non invertible')
    end

    %% i j swaps
    L([i,j],:) = L([j,i],:);
    U([i,j],:) = U([j,i],:);
    P([i,j],:) = P([j,i],:);

    %% Defining scalar
    for j = (i+1):n
        s = -U(j,i)/U(i,i); % Calculates scalar
        U(j,:) = U(j,:) + s*U(i,:);
        L(j,i) = -s; % Stores negated scalar
        %% Displaying matrix values (somewhat broken)
        fprintf('L Matrix: %f %f %f\n', L)
        fprintf('U Matrix: %f %f %f\n', U)
    end
end
L = L + (eye(n,n)) % 1s on diagonal
x = A\b;
[L, U, P] = luFactor(A);
end