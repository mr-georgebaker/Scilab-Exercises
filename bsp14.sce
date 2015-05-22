// Prints out a lookup-table for two different integration methods (trapez rule and simpson rule)
// for three different amount of nodes each

clear

function y = f(x)
// Returns the value y = sin(x)
// Input: x = number or vector
// Output: y = number or vector
    y = sin(x)
endfunction

function I = trapez(f,a,b,N)
// Calulates the integral of f(x) from a to b by using the trapez rule with
// N nodes
// Input: f = function
//        a = number (lower bound)
//        b = number (upper bound)
//        N = number (amount of nodes)
// Output: I = number (area)
    I = 0
    x = linspace(a,b,N+1)
    y = f(x)
    for i = 1:1:N
        I = I + ((x(i+1)-x(i))*(y(i)+y(i+1)))/2
    end
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

function bsp14()
// Presents the solution
    lower = 0
    upper = 5
    mprintf('n \t Trapez \t Simpson \n')
    mprintf('----------------------------------\n')
    for i = 2:2:6
        I1 = trapez(f,lower,upper,i*2)
        I2 = simpson(f,lower,upper,i)
        mprintf('%i \t %.7f \t %.7f \n',i*2+1,I1,I2)
    end
endfunction

bsp14()
