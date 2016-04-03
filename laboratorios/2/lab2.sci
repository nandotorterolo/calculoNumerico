// Laboratorio 2

//Diferenciacion Progresiva
function y=diferenciacionProgresiva(f,h,x)
    y= (f(x+h) - f(x)) ./ h
endfunction 

// Derivada Central
function y=diferenciacionCentral(f,h,x)
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

// Ejemplo de como probarlo
function Prueba()
    f= sin
    x= [0:0.1:%pi]
    h= 0.01
    y=diferenciacionProgresiva(f,h,x)
    plot(x,y)
endfunction

// En valores cercanos al h = 0, en el momento de hacer raiz(h) / h
// scilab comienza a estimar los valores de h, 
// haciendo que la relacion sea érronea, y la grafica se parta al final
// esto es debido al llamado epsilon de maquina, que es el numero mas pequeño que la maquina sporta
function Parte1C()
    f= sqrt
    x=1
    p=1.5;
    k=[1:1:100];
    h= p^(-k)
    y=diferenciacionProgresiva(f,h,x)
    plot(k,y)
endfunction

///EJ 3
function ty=Taylor(fn, a, h)
	ty = fn(a) + (diferenciacionCentral(fn, h, a)*h) + (diferenciacionCentralSeg(fn, h, a))*(h^2/2)
endfunction