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
    contador = 30; /// cuantas veces se va a ejecutar la interacion como max
    x=[]
    [n,m] = size (A);
    X = zeros(n,1);
    R= inv(Q)*(Q-A);
    bR = inv(Q)*b;
    X = [X R*X(:,$) + bR];
    norma = 0;
    while norm(X(:,$) - X(:,$-1)) > tol & contador >0
        contador = contador-1
        X = [X R*X(:,$) + bR];        
        if(norm(X(:,$) - X(:,$-1)) < tol) then
            contador =0
        end
    end
    if(norm(X(:,$) - X(:,$-1)) > tol) then
        norma = norm(X(:,$) - X(:,$-1));
        disp("No converge")
        disp(norma)
        disp("X")
        disp(X);
    else
        norma = norm(X(:,$) - X(:,$-1));
        disp(norma, "CONVERGE  metodo general; NORMA:")
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

    x=[]
    maxIter = 50
    [n,m] = size (A);
    [L,U,D] = LUD(A)
    X = zeros(n,1);
    converge = 0;
    ////mejorar esto
        Xnuevo = zeros(n,1);
        for i=1:n
            sumatoria = 0;
            for j=1:n
                if (i<>j) then
                    sumatoria = sumatoria + (A(i,j)* X(j,1));
                end

            end    
            
            Xnuevo(i)=(1/A(i,i))*(b(i) -sumatoria);
        end
        X = [X Xnuevo]    ;
    
    ////fin mejorar esto    
    
    
    while norm(X(:,$) - X(:,$-1)) > tol & maxIter >0
        Xnuevo = zeros(n,1);
        for i=1:n
            sumatoria = 0;
            for j=1:n
                if (i<>j) then
                    sumatoria = sumatoria + (A(i,j)* X(j,$));
                end

            end    
            
            Xnuevo(i)=(1/A(i,i))*(b(i) -sumatoria);
        end
        X = [X Xnuevo]    ;
        maxIter = maxIter -1;
        
    end
    if norm(X(:,$) - X(:,$-1)) > tol then
        norma = norm(X(:,$) - X(:,$-1));
        disp(norma, "No converge; norma:")
        disp("X")
        disp(X);
    else
        norma = norm(X(:,$) - X(:,$-1));
        disp(norma, "Converge metodo jacobi; NORMA:")
        x=X(:,$);
    end

endfunction

// Implementacion de método Gauss-Seidel para sistemas lineales.
// A Matriz de coeficientes [nxn]
// b Vector [nx1]
// tol máximo error soportado
// x resultado de Ax = b
function x = GaussSeidel(A, b, tol)

    x=[]
    maxIter = 50
    [n,m] = size (A);
    [L,U,D] = LUD(A)
    X = zeros(n,1);
    converge = 0;
    ////mejorar esto
       Xnuevo = zeros(n,1);
        for i=1:n
            sumatoria = 0;
            for j=1:i-1
                sumatoria = sumatoria + (A(i,j)* Xnuevo(j,$));

            end    
            
            sumatoria2 = 0;
            for j=i+1:n
                sumatoria2 = sumatoria + (A(i,j)* X(j,$));
            end    
            Xnuevo(i)=(1/A(i,i))*(b(i) -sumatoria - sumatoria2);
        end
        X = [X Xnuevo]    ;
    
    ////fin mejorar esto    
    
    
    while norm(X(:,$) - X(:,$-1)) > tol & maxIter >0
        Xnuevo = zeros(n,1);
        for i=1:n
            sumatoria = 0;
            for j=1:i-1
                sumatoria = sumatoria + (A(i,j)* Xnuevo(j,$));

            end    
            
            sumatoria2 = 0;
            for j=i+1:n
                sumatoria2 = sumatoria + (A(i,j)* X(j,$));
            end    
            Xnuevo(i)=(1/A(i,i))*(b(i) -sumatoria - sumatoria2);
        end
        X = [X Xnuevo]    ;
        maxIter = maxIter -1;
        
    end
    if norm(X(:,$) - X(:,$-1)) > tol then
        norma = norm(X(:,$) - X(:,$-1));
        disp(norma, "No converge; norma:")
        disp("X")
        disp(X);
    else
        norma = norm(X(:,$) - X(:,$-1));
        disp(norma, "Converge metodo gauss seidel; NORMA:")
        x=X(:,$);
    end

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
     A = [10 -1 2 0; -1 11 -1 3; 2 -1 10 -1;     0 3 -1 8] 
     b= [6; 25; -11; 15]
     tol = 0.01
     [L,U,D]=LUD(A);
     disp(General(A, b, L, tol),"Resultado General")
     disp(A\b, "resultado esperado")
 endfunction


 function test1Jacobi ()
     A = [10 -1 2 0; -1 11 -1 3; 2 -1 10 -1;     0 3 -1 8] 
     b= [6; 25; -11; 15]
     tol = 0.00001
//     [L,U,D]=LUD(A);
     disp(Jacobi(A, b, tol),"Resultado Jacobi")
     disp(A\b, "resultado esperado")

 endfunction


function todosLosTest()

     A = [10 -1 2 0; -1 11 -1 3; 2 -1 10 -1;     0 3 -1 8] 
     b= [6; 25; -11; 15]
     tol = 0.00001
     disp(A\b, "resultado esperado")
     [L,U,D]=LUD(A);
     disp(General(A, b, L, tol),"Resultado General")
     disp(Jacobi(A, b, tol),"Resultado Jacobi")
     disp(GaussSeidel(A, b, tol),"Resultado Gauss-Seidel")
endfunction
