// Laboratorio 2

// *****************************************
// * Universidad Católica del Uruguay
// * Cálculo Numérico 2016
// * Laboratorio 2
// * Eduardo Senturión - Federico González
// *****************************************

// Esta función se utiliza para saber quienes son los participantes del grupo
function Grupo=AlumnosDelGrupo()
    Grupo = {};
    Grupo.Nombre1 = "Nombre del participante 1";
    Grupo.Nombre2 = "Nombre del participante 2";
    Grupo.Nombre3 = "Nombre del participante 3";
endfunction

// Implementacion de derivadaCoc
function y=derivadaCoc(f,x,h)
    y=diferenciacionProgresiva(f,x,h)
endfunction

// Implementacion de derivadaCoc
function y=derivadaCen(f,x,h)
    y=diferenciacionCentral(f,x,h)
endfunction

// Se debe retornar en x e y los vectores de coordenadas a graficar en la parte 1 C.
// En valores cercanos al h = 0, en el momento de hacer raiz(h) / h
// scilab comienza a estimar los valores de h, 
// haciendo que la relacion sea érronea, y la grafica se parta al final
// esto es debido al llamado epsilon de maquina, que es el numero mas pequeño que la maquina sporta
function [x, y]=Pate1C()
    f= sqrt
    k=1
    p=1.5;
    x=[1:1:100];
    h= p^(-k)
    y=diferenciacionProgresiva(f,h,k)
endfunction

// Se debe implementar la función de richardson para mejorar el valor la derivada de cocientes incrementales
function y=richardson(phi,h,n) 
endfunction


// Se debe implementar una función que estime el valor de una funcion utilizando taylor
// fpri es la derivada primera
// fpri es la derivada segunda
// f(x0) = f0
// f(xf) es el valor que se debe retornar en y.
function y=taylor(fpri, fseg, f0, x0, xf)
    ty = f0 + (fpri(x0)*xf-x0) + (fseg(x0))*(xf-x0^2/2)
endfunction

//Diferenciacion Progresiva
function y=diferenciacionProgresiva(f,x,h)
    y= (f(x+h) - f(x)) ./ h
endfunction 

// Derivada Central
function y=diferenciacionCentral(f,x,h)
    y= (f(x+h) - f(x-h)) ./ (2*h)
endfunction 

// Derivada Central
function y=diferenciacionCentralSeg(f,h,x)
    y= (f(x+h) - 2*f(x) + f(x-h)) ./ (h^2)
endfunction 

// Error Absoluto
function ea=errorAbsoluto(x,xReal)
    ea = abs(x -xReal)
endfunction 

// Error Relativo
function er=errorRelativo(x,xReal)
    er = errorAbsoluto(x,xReal)/abs(x)
endfunction 


///EJ 3
function ty=Taylor(fn, a, h)
	ty = fn(a) + (diferenciacionCentral(fn, h, a)*h) + (diferenciacionCentralSeg(fn, h, a))*(h^2/2)
endfunction