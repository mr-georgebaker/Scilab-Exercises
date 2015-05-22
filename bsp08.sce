// Calculates the roots of a function f(x) = 0.6*epx(x) - x - 0.5 based on fixed-point iteration for different starting values x_1 = 0.1,0.2,...,1.0 and an accuracy for eps = 1e-6 or k = kmax
// Prints out the different values for each starting value as well as a plot containing the function, the function used for the fixed-point iteration and a part of the iteration itself

clear

function y = phi(x)
// Returns the value x = 0.6*exp(y)-0.5
// Input: y = number
// Output: x = number
    y = 0.6*exp(x)-0.5
endfunction

function x = fixiter(phi,x1,eps,kmax)
// Returns a vector x which contains all x_k such that x_(k+1) = phi(x_k)
// based on fixed-point iteration for a function phi. The iteration ends if
// |(x_(k+1) - x_k)/x_k| < eps or k = k_max
// Input: phi = function
//        x1 = number (start value)
//        eps = number
//        kmax = number
// Output: x = vector
    i = 1
    while %T
        x(i) = phi(x1)
        if i > 1 & (abs((x(i)-x(i-1))/x(i-1)) < eps | i >= kmax) then
            x(i) = []
            break
        end
        x1 = x(i)
        i = i + 1
    end
endfunction

function plots(x0)
// Creates the plots
    x = (0:0.005:0.5)
    func_exp = 0.6*exp(x)-0.5
    func = 0.6*exp(x)-x-0.5
    plot(x',[x',func', func_exp'])
    for i=1:8
        y(1)=x0(i)
        y(2)=x0(i+1)
        x1(1)=x0(i)
        x1(2)=x0(i)
        plot(x1,y,'g')
        y(1)=x0(i+1)
        y(2)=x0(i+1)
        x1(1)=x0(i)
        x1(2)=x0(i+1)
        plot(x1,y,'g')
    end
    h1 = legend(['x','0.6*epx(x) - x - 0.5','0.6*epx(x) - 0.5','iteration steps'])
endfunction

function bsp08()
// Presents the solution
    eps = 1e-6
    kmax = 100
    mprintf('Startvalue\t Endvalue\n')
    for x1 = 0.1:0.1:1
        x = fixiter(phi,x1,eps,kmax)
        if x1 == 0.1
            plots(x)
        end
        mprintf('%.1f\t %f\n',x1,x($))
    end
endfunction

bsp08()
