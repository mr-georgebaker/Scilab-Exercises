// Creates two plots: The first contains the solution for the differential equation
// y''(t) = -w^2*y(t) (harmonic oscillator) for w = 5
// The second contains the total amount of energy (potential + kinetic) for each step

clear

function y = f(w,t)
// Returns the value for y = -25*t
// Input: t = number or vector
//        w = number (frequency)
// Output: y = number or vector
    y = -w^2*t
endfunction

function [un1,vn1,en] = verlet(w,un,vn,h,m,f)
// Solves the differential equation 
// y''(t) = -w^2*y(t) (harmonic oscillator)
// numerically using velocity verlet algorithm 
// Input: w = number (oszillator frequency)
//        un = number (starting value for y)
//        vn = number (starting value for v)
//        h = number (delta t)
//        m = number (mass)
//        f = function (=y''(t))
// Output: un1 = number (y value)
//         vn1 = number (velocity)
//         en = number (energy)
    un1 = un + vn*h + (f(w,un)*h^2)/2
    vn1 = vn + (h/2)*(f(w,un1)+f(w,un))
    en = (1/2)*(m*w^2*un^2+m*vn^2)
endfunction

function plots(lower,upper,N,t0,v0,w,m,col)
// Creates the plots
// Input: lower = number (lower bound)
//        upper = number (upper bound)
//        N = number (amount of nodes)
//        y0 = number (start value)
//        v0 = number (start velocity)
//        w = number (frequency)
//        m = number (mass)
//        col = string (color)
// Output: Plots
    t = linspace(lower,upper,N)'
    h = t(2)-t(1)
    un1 = t0
    vn1 = v0
    for i = 1:1:length(t)
        y(i) = un1
        [un1,vn1,en] = verlet(w,un1,vn1,h,m,f)
        E(i) = en
    end
    subplot(211)
    plot(t,y,col)
    xlabel('t')
    ylabel('y(t)')
    title('Numerical solution of the differential equation y''''(t) = -w²*y(t) with N steps')
    legend('N = 100', 'N = 500', 'N = 1000')
    subplot(212)
    xlabel('t')
    ylabel('E(t)')
    plot(t,E,col)
    legend('N = 100', 'N = 500', 'N = 1000')
endfunction

function bsp18()
// Presents the solution
    w = 5
    lower = 0
    upper = 4*%pi
    y0 = 1
    v0 = 0
    m = 1
    plots(lower,upper,100,y0,v0,w,m,'r')
    plots(lower,upper,500,y0,v0,w,m,'b')
    plots(lower,upper,1000,y0,v0,w,m,'g')
endfunction

bsp18()
