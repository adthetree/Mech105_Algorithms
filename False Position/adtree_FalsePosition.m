function [root, fx, ea, iter] = falsePosition(func, xl, xu, es, maxit, varargin)
%falsePosition finds the root of a function using false position method
%% Calling initial variables
iter = 0; % Sets value to define iteration variable
ea = 100; % error starts as 100 percent since no answer has been guessed
xrold = 1000; % defines an arbitrary large positive value for xr so the error formula can work

%% Calling values for the user to input
% func = input('Enter function phrased with an @(var) beforehand (will default @(x) x.^3) ');
% xl = input('Enter lower bound (will default to -1) ');
xl = -1; % MATLAB GRADER FORMAT
% xu = input('Enter upper bound (will default to 1) ');
xu = 1; % MATLAB GRADER FORMAT
% es = input('Enter error stopping criteria (will default to 0.0001%) ');
es = 0.000001; % MATLAB GRADER FORMAT
% maxit = input('Enter maximum iterations (will default to 200) ');
maxit = 200; % MATLAB GRADER FORMAT

% Allows empty inputs to default to the values listed below
if isempty(func) == 1 % Checks if input value is blank
    func = @(x) x.^3; % Value the variable defaults to
end
if isempty(xl) == 1
    xl = -1;
end
if isempty(xu) == 1
    xu = 1;
end
if isempty(es) == 1
    es = 0.000001;
end
if isempty(maxit) == 1
    maxit = 200;
end

% Errors if user enters invalid imputs
%if func(xl)*func(xu) > 0 % Detects a sign change
%    error('Root not bracketed')
%end

%% False position loop

while (1)
    xr = xu - ((func(xu)*(xl-xu))/(func(xl)-func(xu))); % False position formula
    iter = iter + 1; % Logs iteration
    if xr ~= 0
        ea = abs((xr-xrold)/xr) * 100; % Approximate relative error formula
        xrold = xr; % Replaces xrold to calculate appox rel error for next iteration
    end

    test = func(xl) * func(xr); % Tests to find which bound to move
    if test < 0
        xu = xr; % Moves upper bound
    elseif test > 0
        xl = xr; % Moves lower bound
    else
        ea = 0; % The root is xr and therefore, the error is 0
        break
    end
    if ea <= es || iter >= maxit % When the stopping error or max iteraton are reached, the loop stops
        break
    end
end

%% Displaying root and other relevant info
fprintf('Root: %f\n', xr)
fprintf('Number of iterations: %1.0f \n', iter)
fprintf('Percent Error: %f \n', ea)