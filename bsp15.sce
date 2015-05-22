// Calculates the integral of a function f(x) by using simpson's rule recursivly

clear

function y = f(x)
// Returns the value y = 1/sqrt(x)
// Input: x = number or vector
// Output: y = number or vector
    y = 1 ./sqrt(x)
endfunction

function I = simpson(f,a,b,N)
// Calulates the integral of f(x) from a to b by using the simpson rule with
// N nodes
// Input: f = function
//        a = number (lower bound)
//        b = number (upper bound)
//        N = number (amount of nodes)
// Output: I = number (area)
    I = 0
    x = linspace(a,b,N+1)
    for i = 1:1:N
        I = I + ((x(i+1)-x(i))*(f(x(i))+4*f((x(i+1)+x(i))/2)+f(x(i+1))))/6
    end
endfunction

function I = recsimp(f,a,b,eps,k,kmax)
// Retuns the value of the integral of f(x) by recursivly applying simpson's rule
// where either |(I2-I1)/I1| < eps or k >= kmax in each subinterval
// Input: f = function
//        a = number (lower bound)
//        b = number (upper bound)
//        eps = number (accuracy)
//        k = number (amount of iterations)
//        kmax = number (maximum amount of iterations)
// Output: I = number (area)
    I1 = simpson(f,a,b,1)
    I2 = simpson(f,a,b,2)
    if abs((I2-I1)/I1) < eps | k >= kmax then
        I = I2
        mprintf('%.6f \t %.6f \t %i\n',a,b,k)
    else
        I = recsimp(f,a,(a+b)/2,eps,k+1,kmax) + recsimp(f,(a+b)/2,b,eps,k+1,kmax)
    end
endfunction

function bsp15()
// Presents the solution
    lower = 10^(-4)
    upper = 1
    eps = 10^(-4)
    kmax = 20
    I = recsimp(f,lower,upper,eps,1,kmax)
    disp(I)
endfunction

bsp15()
