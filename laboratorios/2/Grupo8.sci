// Universidad Católica del Uruguay
// Cálculo Numérico
// Eduardo Senturión, Federico González
// Laboratorio 1
// solo se debe tocar este archivo, no tocar el otro. Alegir un numero al azar y poner todos los participantes
// participantes=['FernandoTorterolo', 'MartinDaRosa', 'PabloFernandez'];

// Escriba una función scilab y=derivadaCoc(f,x,ℎ) que reciba una función real f?, un
// número real x y un paso de aproximación h; y determine la aproximación de cociente
//incremental para la derivada. Escríbala de modo que h pueda ser un vector.
function y=derivadaCoc(f,h,x)
    y= (f(x+h) - f(x)) ./ h
endfunction 

//Escriba una función scilab y=derivadaCen(f, x, h) que reciba una función real f, un
//número real x y un paso de aproximación h; y determine la aproximación de derivada
//central para la derivada. Escribala de modo que h pueda ser un vector.
function y=derivadaCen(f,h,x)
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
    y=derivadaCoc(f,h,x)
    plot(x,y)
endfunction

// Se llama
// [k,y]=Parte1C();
// plot(k,y,k)
// plot(k,y,k,ones(100,1)*0.5)  hace una linea
// En valores cercanos al h = 0, en el momento de hacer raiz(h) / h
// scilab comienza a estimar los valores de h, 
// haciendo que la relacion sea érronea, y la grafica se parta al final
// esto es debido al llamado epsilon de maquina, que es el numero mas pequeño que la maquina sporta
function [k,y]=Parte1C()
    f= sqrt
    x= 1
    p= 1.5
    k= [1:1:100]
    h=p^(-k)
    y=derivadaCoc(f,h,x)
    plot(k,y,k,ones(100,1)*0.5)  
endfunction