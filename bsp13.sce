// Creates two plots:
// The first contains a function f(x) = exp(-x^2/2), the analytic derivative -x*exp(-x^2/2)
// and numerical derivatives based on the difference quotient for three different amount of nodes
// The second contains the numerical derivative where the function value contains an error by adding
// a normal distributed number in the interval [-0.001,0.001] for two different amount of nodes

clear

function y = f(x)
// Returns the value y = e^(-x^2/2)
// Input: x = number or vector
// Output: y = number or vector
    y = exp(-x.^2/2)
endfunction

function dy = df(x)
// Returns the value y = -x*e^(-x^2/2) (derivative of f(x), analytic)
// Input: x = number or vector
// Output: y = number or vector
    dy = -x.*exp(-x.^2/2)
endfunction

function yp = derive(y,h)
// Returns the value yp = f'(x) based on difference quotient
// f'(t_i) = (1/(2*h))*(f(t_(i+1))-f(t_(i-1)))
// At boundery points:
// f'(t_(i-1)) = (1/(2*h))*(-f(t_(i+1))+4*f(t_i)-3*f(t_(i-1)))
// f'(t_(i+1)) = (1/(2*h))*(3*f(t_(i+1))-4*f(t_i)+f(t_(i-1)))
// Input: y = vector (f(h))
//        h = vector (delta x)
// Output: yp = vector (numerical derivative)
    dh = h(2)-h(1)
    yp(1) = (-y(3)+4*y(2)-3*y(1))/(2*dh)
    for i = 2:1:length(y)-1
        dh = h(i+1)-h(i-1)
        yp(i) = (y(i+1)-y(i-1))/(dh)
    end
    yp($+1) = (3*y($)-4*y($-1)+y($-2))/(2*(h($)-h($-1)))
endfunction

function y_err = f_err(x,lower,upper)
// Retuns y_err = x + random number between lower and upper bound
// Input: x = vector
//        lower = number (lower bound)
//        upper = number (upper bound)
// Output: y_err = vector
    rand("normal")
    for i = 1:1:length(x)
        y_err($+1) = x(i) + rand(1)*(upper-lower)+lower
    end
endfunction

function bsp13()
// Presents the solution
    col(10) = 'r'
    col(20) = 'm'
    col(30) = 'g'
    col(100) = 'k'
    col(1000) = 'b'
    for i = 10:10:30
        h = linspace(-3.5,3.5,i)'
        y = f(h)
        yp = derive(y,h)
        subplot(211)
        plot(h,yp,col(i))
    end
    x1 = linspace(-3.5,3.5,1000)'
    subplot(211)
    plot(x1,[df(x1),f(x1)])
    legend('10 Stützstellen', '20 Stützstellen', '30 Stützstellen', 'Analytische Ableitung', 'f(x)')
    
    for i = 1000:-900:100
        h = linspace(-3.5,3.5,i)'
        y = f(h)
        y_err = f_err(y,-0.001,0.001)
        dy_err = derive(y_err, h)
        subplot(212)
        plot(h,dy_err,col(i))
    end
    legend('1000 Stützstellen mit Fehler', '100 Stützstellen mit Fehler')
endfunction

bsp13()


