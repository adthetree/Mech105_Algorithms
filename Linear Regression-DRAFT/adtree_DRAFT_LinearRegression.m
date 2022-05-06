function [fX, fY, slope, intercept, Rsquared] = linearRegression(x,y)
%linearRegression Computes the linear regression of a data set
%   Compute the linear regression based on inputs:
%     1. x: x-values for our data set
%     2. y: y-values for our data set
%
%   Outputs:
%     1. fX: x-values with outliers removed
%     2. fY: y-values with outliers removed
%     3. slope: slope from the linear regression y=mx+b
%     4. intercept: intercept from the linear regression y=mx+b
%     5. Rsquared: R^2, a.k.a. coefficient of determination

% Adrian Deputat

% Test Variables

if length(y) ~= length(x)
    error('x and y arrays must be equal lengths')
end
% Sort
fX = x;
fY = y;
[fY,i] = sort(fY);
fX = fX(i);

% Finding IQR

n = length(fY);

Q1 = fY(floor((n+1)/4));
Q3 = fY(floor((3*n+3)/4));
IQR = Q3 - Q1;

low = Q1 - 1.5*IQR;
up = Q3 + 1.5*IQR;

% Eliminating outliers from variables

outlier = [fY<= low | fY>=up];
outlier_index = find(outlier);
fY = fY(fY<= up & fY>=low);
fX = fX(x~=outlier_index);

if length(fY) ~= length(fX) % Making sure arrays are still equal
    error('guess this wasnt an effective meathod')
end

% Sorting Modified Variables

[sortedY, sortOrder] = sort(fY);
sortedX = fX(sortOrder);

fprintf('Filtered x:\n')
repmat('%f ', 1, length(fX));
sprintf(repmat('%f ', 1, length(fX)), fX)

fprintf('Filtered y:\n')
repmat('%f ', 1, length(fY));
sprintf(repmat('%f ', 1, length(fY)), fY)
% Normal Equations - Fining Least Squares Fit
a_1 = ((n*sum(fX.*fY))-(sum(fX)*sum(fY)))/(n*sum(fX.^2)-sum(fX)^2);
a_0 = mean(fY)-a_1*mean(fX);
err = fY-a_0-a_1*fX;
F = a_1*fX+a_0;
F_err = a_1*fX+a_0+err;

% Renaming variables

slope = a_1;
intercept = a_0; % mfw I mispell intercept multiple times:  :(
fprintf('Slope: %f\n',a_1)
fprintf('Intercept: %f\n',a_0)

% Calculating Rsquared
SS_tot = sum((fY-mean(fY)).^2);
SS_res = sum((fY-F).^2);
Rsquared = 1-(SS_res/SS_tot);
fprintf('Rsquared: %f\n',Rsquared)

% Extra graph to see fit for brownie points
plot(fX,F,fX,F_err, 'r*')
title('Linear Regression to Data Point Representation')
xlabel('x')
ylabel('y')
end