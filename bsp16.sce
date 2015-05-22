// Creates a plot for the numerical solution of the one-dimensional static heat equation
// for different amount of nodes
// d²T(x)/dx² = -10/a for a = 1, T(0)=T(1)=25

clear

function y = T(x)
// Returns the value for the analytic solution of the differential equation
// d²T(x)/dx² = -10/a for a = 1, T(0)=T(1)=25
// T(x) = -5x²+5x+25
// Input: x = number or vector
// Output: f = number or vector
    y = -5*x.^2 + 5*x + 25
endfunction

function T = station_heat(n)
// Returns a vector cointaing the solutions to the differential equation
// d²T(x)/dx² = -10/a for a = 1, T(0)=T(1)=25
// based on difference quotient by solving a system of linear equations
// Input: n = number (amount of nodes)
// Output: T = vector
    x = linspace(0,1,n+2)
    h = x(2)-x(1)
    T(1) = 0
    M1 = -2*eye(n,n)
    M2 = tril(triu(ones(n,n),1),1)
    M3 = triu(tril(ones(n,n),-1),-1)
    M = (1/h^2)*(M1 + M2 + M3)
    b = -10*ones(n,1)
    T(2:n+1)= M\b
    T($+1) = 0
    T = T+25
endfunction

function plots(n,col)
// Plots the solution returned by station_heat
// Input: n = number
//        col = string (color of graph)
// Output: Plot
    x = linspace(0,1,n+2)'
    T = station_heat(n)
    plot(x,T,col)
    title('Numerical solution of the one-dimensional heat-equation with T(0)=T(1)=25 for N nodes')
    xlabel('x')
    ylabel('T(x)')
endfunction

function bsp16()
// Presents the solution
    x = linspace(0,1,100)
    plot(x,T(x))
    plots(3,'g')
    plots(5,'r')
    plots(11,'k')
    legend('Analytic solution', 'N = 3', 'N = 5', 'N = 11')
endfunction

bsp16()
