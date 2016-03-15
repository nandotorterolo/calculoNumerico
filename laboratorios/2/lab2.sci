// Laboratorio 2

//Diferenciacion Progresiva
function y=diferenciacionProgresiva(f,h,x)
    y= (f(x+h) - f(x)) ./ h
endfunction 

// Derivada Central
function y=diferenciacionCentral(f,h,x)
    y= (f(x+h) - f(x-h)) ./ (2*h)
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


