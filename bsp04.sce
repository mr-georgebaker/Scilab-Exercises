clear

// Calculates the condition number, as well as the relative error, for a system of linear equations containing the 4x4 hilbert matrix and two vectors b = [1;1;1;1] and bs = [1;1;1;1.001];

// In the field of numerical analysis, the condition number of a function with respect to an argument measures how much the output value of the function can change for a small change in the input argument.

b = [1;1;1;1];
bs = [1;1;1;1.001];

function dx = rel_error(xs, x)
// Returns the relative error for two vectors (one with "true" values and one with "variance of error")
// Input: xs = vector
//        x = vector
// Output: dx = number
    dx = norm(xs-x)/norm(x)
endfunction

function K = condition_number(H)
// Returns the condition number for a given matrix
// Input: H = matrix
// Output: K = number
    K = norm(H)*norm(inv(H))
endfunction

function H = hilbert_matrix(n)
// Returns n-dimensional hilbert matrix
// Input: n = number
// Output: H = matrix
    for i = 1:1:4
        for j = 1:1:4
            H(i,j) = 1/(i+j-1);
        end
    end
endfunction

function bonus()
// Bonus excercise: Plots a histogram from 0-200 of condition numbers for 
// 10000 random 4x4 matrices
    for i = 1:1:10000
        cond_list(i) = cond(rand(4,4));
    end
    K_min = min(cond_list);
    K_max = max(cond_list);
    clf(); 
    histplot([0:200],cond_list)
    mprintf('\n ϰ_min = %.4f \t ϰ_max = %.4f',K_min,K_max)
endfunction

function bsp4()
    H = hilbert_matrix(4)
    x = H\b
    xs = H\bs
    dx = rel_error(xs,x)
    db = rel_error(bs,b)
    K = condition_number(H)
    Ku = dx/db
    mprintf('Δb = %.4f \t ϰ_u = %.2f \t ϰ = %.3f",db,Ku,K)
    bonus()
endfunction

bsp4()









