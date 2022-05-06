# False Position 
A MATLAB function which estimates the root of a given function using the false position meathod.

To estimate the root the inputs required are:
1) the function being evaluated
2) the lower bound
3) the upper bound
4) the desired relative/stopping error (defaults to 0.0001%)
5) the maximum number of iterations to use (defaults to 200)

The outputs of the function are:
1) the estimated root location
2) the value of the function evaluated at the root location
3) the approximate relative error (%)
4) the amount of iterations performed
