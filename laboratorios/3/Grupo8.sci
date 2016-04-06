// *****************************************
// * Universidad Católica del Uruguay
// * Cálculo Numérico 2016
// * Laboratorio 3
// * Eduardo Senturión - Federico González
// *****************************************

// Esta función se utiliza para saber quienes son los participantes del grupo
function Grupo=AlumnosDelGrupo()
    Grupo = {};
    Grupo.Nombre1 = "FernandoTorterolo";
    Grupo.Nombre2 = "MartinDaRosa";
    Grupo.Nombre3 = "PabloFernandez";
endfunction

// Implementacion de escalerizacion gaussiana
function y = escalerizacionGaussiana(A, b)
endfunction

// Implementacion de escalerizacion utilizando pivot
function y = escalerizacionPivot(A, b)
endfunction

// Implementacion de resolucion del sistema Ax = b utilizando factorizacion LU
function y = resolucionLU(A, b)
    [L, U] = LU(A);
endfunction

// Implementacion de sistema LU
function [L, U] = LU(A, b)
endfunction 
