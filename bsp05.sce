clear

// Calculates the activation energy E and the factor A for the formula 
// K_i = A*exp(-E/(R*T_i))
// based on a lookuptable (Bsp05_Messdaten.txt) and regression analysis with least squares
// ||Mx - b|| = min
// where M_i = [1, -1/T_i]

R = 8.3144621

function D = open_file(path)
// Reads a file and returns a matrix containing the elements in that file
// Input: path = String
// Output: D = matrix
    try
        //file_path = path
        D=fscanfMat(path)
    catch
        disp(['File ' + path + 'cannot be found',
            'using given values'])
        D = [1, 605.7, 4.80e-5;
            2, 605.7, 4.73e-5;
            3, 617.6, 10.59e-5;
            4, 617.6, 10.66e-5;
            5, 623.2, 15.01e-5;
            6, 623.2, 15.06e-5;
            7, 634.5, 30.50e-5;
            8, 634.5, 30.20e-5,
            9, 648.0, 69.80e-5,
            10, 648.0, 70.10e-5,
            11, 648.0, 70.00e-5]
    end
endfunction

function M = ansatzfunction(D)
// Returns the matrix M which contains the ansatzfunctions f_1(T) = 1 and 
// f_2(T) = -1/T
// Input: D = matrix 
// Output: M = matrix
    for i=1:1:size(D,1)
        M(i,1) = 1
        M(i,2) = -1/D(i,2)
    end
endfunction

function bsp5()
    D = open_file('Bsp05_Messdaten.txt')
    M = ansatzfunction(D)
    y = log(D(1:$,3)) // ln(K_i)
    M_1 = M'*M // M^T*M
    M_2 = M'*y // M^T*y
    // M^T*M*x = M^T*y -> x = M_1\M_2
    x = M_1\M_2 //ln(A) = x(1), E = R*x(2)
    E = R*x(2)
    ln_A = x(1)
    mprintf('E = %.0f \t ln(A) = %.2f",E,ln_A)
endfunction

bsp5()
