clear

function y = func(x)
// Returns the value of the function y = 1/(1+2*x^2)
// Input: x = number or vector
// Output: y = number or vector
    y = 1 ./(1+2*x.^2)
endfunction

function t = chebyshev(a,b,n)
// Returns grid points based on the chebyshev formula
// Input: a = number (interval begin)
//        b = number (interval end)
//        n = number (amount of points)
// Output: t = vector
    for i = 1:1:n
        t(i) = (a+b)/2 + ((b-a)/2)*cos(((2*i-1)/(2*n))*%pi)
    end
endfunction

function L = lagrange_polynom(x,xi,i)
// Retuns the value of the i-th langrange-polynomial at x
// L_i(x) = prod((x-x_k)/(x_i-x_k)) for k ~= i
// Input: x = number
//        xi = vector (node values)
//        i = number (i-th lagrange-polynomial)
// Output: L = number
    L = 1
    for k = 1:1:length(xi)
        if i ~= k then
            L = L*(x-xi(k))/(xi(i)-xi(k))
         end
    end
endfunction

function y = Lagrange(t,f,x)
// Returns the value of the lagrangian interpolationpolynom 
// P(x) = sum(f_i*L_i(x)) from 0 to n 
// Input: t = vector (node values)
//        f = vector (basic value)
//        x = vector (values where the interpolationpolynom should be calculated)
    for i = 1:1:length(x)
        y(i) = 0
        for j = 1:1:length(f)
            y(i) = y(i) + f(j)*lagrange_polynom(x(i),t,j)
        end
    end
endfunction

function plots(x,t,y,i,j,description)
// Plots the function, lagrangian interpolation as well as the nodes
    subplot(2,4,j)
    plot2d(x,[func(x),y],rect=[-3,-0.5,3,1.5])
    plot2d(t,func(t),-5,rect=[-3,-0.5,3,1.5])
    xtitle(description, 'Stützstellen  ' + string(i))
endfunction

function bsp10()
// Presents the solution
    xval = linspace(-3,3,100)'
    a = -3
    b = 3
    i = 5
    j = 1
    while i <= 40
        t = linspace(a,b,i)'
        f = func(t)
        y = Lagrange(t,f,xval)
        plots(xval,t,y,i,j,'Äquidistant')
        t = chebyshev(a,b,i)
        f = func(t)
        y = Lagrange(t,f,xval)
        plots(xval,t,y,i,j+4,'Chebyshev')
        i = i*2
        j = j + 1
    end
endfunction

bsp10()

