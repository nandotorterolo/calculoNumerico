// *****************************************
// * Universidad Católica del Uruguay
// * Cálculo Numérico 2016
// * Laboratorio 4
// * Eduardo Senturión - Federico González
// *****************************************

// Esta función se utiliza para saber quienes son los participantes del grupo
function Grupo=AlumnosDelGrupo()
    Grupo = {};
    Grupo.Nombre1 = "FernandoTorterolo";
    Grupo.Nombre2 = "MartinDaRosa";
    Grupo.Nombre3 = "PabloFernandez";
endfunction

// Implementacion de método iterativo general para sistemas lineales.
// A Matriz de coeficientes [nxn]
// b Vector [nx1]
// Q Matriz de tipo Jacobi, Richardson, GaussSeidel. Ver LUD
// tol máximo error soportado
// x resultado de Ax = b
function x = General(A, b, Q, tol)
    x=[]
    disp(A\b, "resultado esperado")
    
    [n,m] = size (A);
//    X = zeros(n,1);
    X = [5;2];
    disp (X, "X");
    R= inv(Q)*(Q-A);
    bR = inv(Q)*b;
    X = [X R*X(:,$) + bR];
    disp (X, "X");
    disp (R, "R");
    disp (bR,"bR");
    contador = 5;
    norma = 0;
    while norm(X(:,$) - X(:,$-1)) > tol & contador >0
        disp(norm(X(:,$) - X(:,$-1)) ,"norma")
        X = [X R*X(:,$) + bR];        
//        disp("X")
//        disp(X);
        contador = contador-1
    end
    if contador == 0 then
        norma = norm(X(:,$) - X(:,$-1));
        disp("No converge")
        disp(norma)
        disp("X")
        disp(X);
    else
        x=X(:,$);
    end
    
endfunction

// Implementacion de método Richardson para sistemas lineales.
// A Matriz de coeficientes [nxn]
// b Vector [nx1]
// tol máximo error soportado
// x resultado de Ax = b
function x = Richardson(A, b, tol)
endfunction

// Implementacion de método Jacobi para sistemas lineales.
// A Matriz de coeficientes [nxn]
// b Vector [nx1]
// tol máximo error soportado
// x resultado de Ax = b
function x = Jacobi(A, b, tol)
endfunction

// Implementacion de método Gauss-Seidel para sistemas lineales.
// A Matriz de coeficientes [nxn]
// b Vector [nx1]
// tol máximo error soportado
// x resultado de Ax = b
function x = GaussSeidel(A, b, tol)
endfunction

// LUD, funcion que descompone la matriz A
function [L, U, D] = LUD(A)
    [n, m] = size(A);
    
    if n ~= m then
        printf('Matriz A tiene dimensiones [%i, %i]', n, m);
        return;
    end
    
    L = zeros(n, n); U = zeros(n, n); D = zeros(n, n);
    
    for i = 1:1:n 
        D(i, i) = A(i, i);
        L(i, 1:i) = A(i, 1:i);
        U(i, i:n) = A(i, i:n);
    end
endfunction
 
 function test1General ()
     A = [3 -2;1 2] 
     b= [11; 9]
     tol = 1
     General(A, b, tol)
 endfunction
