function x = tri_solve(L,b)
// Calculates x = b\L for L = lower triangular matrix 
// based on forward substitution
// Input: L = lower triangular matrix, b = vector 
// Output: x = vector where Lx=b (equal to the buildin x = b\L)
    [nr,nc] = size(L)
    n = length(b)
    if nr ~= nc then
        error('The matrix is not quadratic!')
    end
    if nr ~= n then
        error('The matrix and the vector do not have the same dimension!')
    end

    for i = 1:1:n
        dummy = 0;
        for j = 1:1:i-1
            dummy = dummy + L(i,j)*x(j);
        end
        x(i) = (b(i)-dummy)/L(i,i);
    end
endfunction

// Test:

L = [2,0,0;
     3,1,0;
     4,2,1]
b = [2;2;3]

// Expected output: x = [1;-1;1]

x = tri_solve(L,b)
