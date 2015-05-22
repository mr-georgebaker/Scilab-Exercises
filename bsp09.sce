// Calculates the roots of a function f(x) = sin(x)/x based on Newton's method in the intveral [-10,10] for a accuracy of eps=1e-6
// Prints out the roots as well as the iterations for the first root > 0
// Plots sin(x)/x in the interval [-10,10] and in the interval [0.06,5] as well as the iterations for this root

clear

function y = f(x)
// Returns the value for sin(x)/x
// Input: x = number or vector
// Output: y = number or vector
    y = sin(x)./x
endfunction

function y = fp(x)
// Returns the value for (sin(x)/x)' = (x*cos(x)-sin(x))/x^2
// Input: x = number or vector
// Output: y = number or vector
    y = (x.*cos(x)-sin(x))./(x.^2)
endfunction

function x = unique_eps(y,eps)
// Rounds the entries of a given vector to 1/eps and deletes non unique entries
// Input: y = vector
//        eps = number
// Output: x = vector
    x = round(y*eps^(-1))/eps^(-1)
    x = unique(x)
endfunction

function x = newton(f,fp,x1,eps,kmax)
// Retuns the roots based on Newton's method where 
// x_(n+1) = x_n - f(x_n)/f'(x_n)
// The iteration ends if
// |(x_(k+1) - x_k)/x_k| < eps or k = k_max
// Input: f = function
//        fp = derivative of the function
//        x1 = number (starting number)
//        eps = number
//        kmax = number
    i = 1
    while %T
        try
            x(i) = x1 - f(x1)/fp(x1)
        catch
            break
        end
        if i > 1 & (abs((x(i)-x(i-1))/x(i-1)) < eps | i >= kmax) then
            break
        end
        x1 = x(i)
        i = i + 1
    end
endfunction

function plots(x0)
// Generates the plots
// Input: x0 = vector
    x = (0.06:0.005:5)
    subplot(122)
    plot(x',f(x)','r')
    x1 = linspace(0.05,5,3)
    for i = 1:1:3
        slope = fp(x0(i))
        ordinate = f(x0(i))-slope*x0(i)
        subplot(122)
        plot(x1',(slope*x1+ordinate)','g')
    end
    h1 = legend(['sin(x)/x','iteration steps'])
    subplot(121)
    x2 = (-10:0.06:10)
    plot(x2',f(x2)')
    plot(x',f(x)','r')
    h2 = legend(['sin(x)/x'])
endfunction

function bsp09()
// Presents the solution
    eps = 1e-6
    kmax = 100
    x1 = -10
    interval_end = 10
    i = 1
    a = 1
    while x1 <= interval_end
        x = newton(f,fp,x1,eps,kmax)
        if abs(x($)) < 10
            root($+1) = x($)
        end
        if x($) > 0 & a < 2
            iter = x
            a = a + 2
        end
        x1 = x1+1
        i = i + 1
    end
    
    root = unique_eps(root,1e-10)
    plots(iter)

    mprintf('List of roots \t Iterations for first root > 0\n\n')
    mprintf('%.10f \t %.10f\n',root,iter)
    
    
endfunction

bsp09()
