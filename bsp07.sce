// Calculates the biggest eigenvalue (absolute value) based on two different algorithms with two different matrices
// 1) direct vectoraddition
// 2) inverse vectoraddition
// A = [1,1;1,2], B = [-0.59980, 0.80040; 0.80040, 0.6080]
// Plots delta_k = lambda_k - lambda_max as a function of k for both algorithms and both matrices to compare the two algorithms

clear

A = [1,1;1,2]
B = [-0.59980, 0.80040; 0.80040, 0.6080]
eps = 1e-6

function [lambda,V] = dir_veciter(A,eps)
// Returns the biggest eigenvalue (absolute value) and a matrix V which contains all vectors v_i for a given matrix A based on direct vectoraddition
//  v_schlange = A*v_k
//  lambda_k = v_schlange*v_k
//  v_(k+1) = v_schlange/||v_schlange||
// Input: A = matrix
//        eps = number
// Output: lambda = number
//         V = matrix

    v_k = rand(2,1)
    v_k = v_k/norm(v_k)
    i = 1
    while %T
        v_schlange = A*v_k
        lambda(i) = v_schlange'*v_k
        if i > 1 & (abs((lambda(i)-lambda(i-1))/lambda(i))) < eps then
            lambda(i) = []
            break
        end
        V(1:length(v_k),i) = v_k
        v_k = v_schlange/norm(v_schlange)
        i = i + 1
    end
endfunction

function[lambda,V] = inv_veciter(A,lest,eps)
// Returns the biggest eigenvalue (absolute value) and a matrix V which contains all vectors v_i for a given matrix A based on inverse vectoraddition
//  v_schlange = (A-lest * unitymatrix)^(-1) * v_k
//  lambda_k = lest + 1/(v_schlange*v_k)
//  v_(k+1) = v_schlange/||v_schlange||
// Input: A = matrix
//        lest = number
//        eps = number
// Output: lambda = number
//         V = matrix

    v_k = rand(2,1)
    v_k = v_k/norm(v_k)
    i = 1
    while %T
        v_schlange = (A-lest*eye(A))^(-1) * v_k
        lambda(i) = lest + 1/(v_schlange'*v_k)
        if i > 1 & (abs((lambda(i)-lambda(i-1))/lambda(i))) < eps then
            lambda(i) = []
            break
        end
        V(1:length(v_k),i) = v_k
        v_k = v_schlange/norm(v_schlange)
        i = i + 1
    end
endfunction

function plots(subplotnumber,x,delta,lambda,label)
// Generates the plots
    subplot(subplotnumber)
    plot2d(x,delta-lambda)
    xlabel('k')
    ylabel('δ')
    h = legend([label])
endfunction

function bsp07()
// Presents the solution
    [lambda1, V1] = dir_veciter(A,eps)
    x1 = [1:1:length(lambda1)]
    [lambda2, V2] = dir_veciter(B,eps)
    x2  =[1:1:length(lambda2)]
    [lambda3, V3] = inv_veciter(A,2,eps)
    x3  =[1:1:length(lambda3)]
    [lambda4, V3] = inv_veciter(B,2,eps)
    x4  =[1:1:length(lambda4)]
    delta1 = max(spec(A))
    delta2 = max(spec(B))
    plots(221,x1,delta1,lambda1,'Iteration: A - direct vectoraddition')
    plots(222,x3,delta1,lambda3,'Iteration: A - inverse vectoraddition')
    plots(223,x2,delta2,lambda2,'Iteration: B - direct vectoraddition')
    plots(224,x4,delta2,lambda4, 'Iteration: B - inverse vectoraddition')
endfunction

bsp07()



