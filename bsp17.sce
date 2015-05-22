// Creates two plots: The first contains numerical solutions for two different methods
// (Euler and Heun) for the differential equation y'(t) = 2*t*y^2(t); 0<=t<=0.9; y(0) = 1
// for different amount of nodes
// The second contains a graphical comparison between the two methods by calculation 
// the difference from the analytic solution for 2,4,6,...,1000 nodes

clear

function y = f_analytic(t)
// Returns the value for the analytic solution of the differential equation
// y'(t) = 2*t*y^2(t); 0<=t<=0.9; y(0) = 1
// y(t) = 1/(1-t^2)
// Input: t = number or vector
// Output: f = number or vector
    y = 1 ./(1-t.^2)
endfunction

function z = f(t,y)
// Returns the value for f(t,y) = 2*t*y^2
// Input: t = number
//        y = number
// Output: z = number
    z = 2*t*y^2
endfunction

function unp1 = euler(un,tn,h,f)
// Returns the value u_(n+1) for the numerical solution of the differential equation
// y'(t) = 2*t*y^2(t); 0<=t<=0.9; y(0) = 1
// using euler method
// Input: un = number (startvalue for y)
//        tn = number (startvalue for x (boundary condition))
//        h = number (delta x)
//        f = function (=y'(t))
// Output: unp1 = number (=y_(i+1))
    tn = tn + h
    unp1 = un + h*f(tn,un)
endfunction

function unp1 = heun(un,tn,h,f)
// Returns the value u_(n+1) for the numerical solution of the differential equation
// y'(t) = 2*t*y^2(t); 0<=t<=0.9; y(0) = 1
// using heun's method
// Input: un = number (startvalue for y)
//        tn = number (startvalue for x (boundary condition))
//        h = number (delta x)
//        f = function (=y'(t))
// Output: unp1 = number (=y_(i+1))
    tn1 = tn + h
    unp1 = un + (h/2)*(f(tn,un)+f(tn1,un+h*f(tn,un)))
endfunction

function plots(lower,upper,N,y0,subplt,col1,col2)
// Creates the plots
// Input: lower = number (lower bound)
//        upper = number (upper bound)
//        N = number (amount of nodes)
//        y0 = number (boundary condition)
//        subplt = number (subplot number)
//        col = string (color)
    x = linspace(lower,upper,N)'
    h = x(2)-x(1)
    y(1,1) = y0
    y(1,2) = y0
    for i = 1:1:length(x)-1
        y(i+1,1) = euler(y(i,1),x(i+1),h,f)
        y(i+1,2) = heun(y(i,2),x(i+1),h,f)
    end
    subplot(subplt)
    plot(x,y(1:$,1),col1)
    plot(x,y(1:$,2),col2)
endfunction

function bsp17()
// Presents the solution
    y0 = 1
    x = linspace(0,0.9,100)'
    subplot(121)
    plot(x,f_analytic(x),'k')
    plots(0,0.9,10,y0,121,'r','r--')
    plots(0,0.9,20,y0,121,'g','g--')
    plots(0,0.9,30,y0,121,'b','b--')
    plots(0,0.9,40,y0,121,'c','c--')
    plots(0,0.9,50,y0,121,'y','y--')
    title('Numerical solution')
    xlabel('x')
    ylabel('f(x)')
    legend(['Analytic', 'Euler N = 10', 'Heun N = 10', 'Euler N = 20', 'Heun N = 20', 'Euler N = 30', 'Heun N = 30', 'Euler N = 40', 'Heun N = 40', 'Euler N = 50', 'Heun N = 50'],2)
    for j = 2:2:1000
        x = linspace(0,0.9,j)'
        h = x(2)-x(1)
        y(1,1) = y0
        y(1,2) = y0
        for i = 1:1:length(x)-1
            y(i+1,1) = euler(y(i,1),x(i+1),h,f)
            y(i+1,2) = heun(y(i,2),x(i+1),h,f)
        end
        eps(j/2,1) = abs(y($,1)-f_analytic(0.9))
        eps(j/2,2) = abs(y($,2)-f_analytic(0.9))
    end
    x = linspace(2,1000,500)'
    subplot(122)
    plot(log(x),log(eps(1:$,1)),'r')
    plot(log(x),log(eps(1:$,2)),'b')
    title('Convergence')
    legend('Euler''s method', 'Heun''s method')
    xlabel('ln(N)')
    ylabel('ln(ε)')
endfunction

bsp17()


