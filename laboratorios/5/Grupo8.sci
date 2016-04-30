// *****************************************
// * Universidad Católica del Uruguay
// * Cálculo Numérico 2016
// * Laboratorio 5
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
// A Matriz sparse [nxn]
// b Vector [nx1]
// x resultado de Ax = b
function x = ResolverTridiagonal(A, b)
    [n m] = size(A)
    AA = A
    bb = b
    for i=2:n
        AA(i,2) = AA(i,2) - AA(i,1) * AA(i-1,3) / AA(i-1,2)
        bb(i) = bb(i) - AA(i,1) * bb(i-1) / AA(i-1,2) 
    end
    x(n) = bb(n) / AA(n,2);
    for i = n-1:-1:1
        x(i) = (bb(i)-AA(i,3)*x(i+1)) / AA(i,2)
    end
    x
endfunction
