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
    Grupo.Nombre1 = "FernandoTorterolo";
    Grupo.Nombre2 = "MartinDaRosa";
    Grupo.Nombre3 = "PabloFernandez";
endfunction

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



// Se debe implementar la función de richardson para mejorar el valor la derivada de cocientes incrementales
function y=richardson(phi,h,n) 
    x = 5;
    printf("Richardson para x = 5")
    Aux=zeros(n,n);
    nivel = 1;
    err = %inf;
    while (nivel <= n)
        Aux(nivel,1) = (phi(x+(h/(2^(nivel-1))))-phi(x))/(h/(2^(nivel-1)));
        if (nivel > 1)
            for (i=2:1:nivel)
                Aux(nivel-i+1,i) = (((2^(i-1))*Aux(nivel-i+2,i-1)) - Aux(nivel-i+1,i-1)) / ((2^(i-1))-1);
                disp(Aux)
            end
            err = abs(Aux(1,nivel) - Aux(2,nivel-1))
        end
        nivel = nivel+1;
    end
    y= Aux(1,nivel-1)
endfunction

// Se debe implementar una función que estime el valor de una funcion utilizando taylor
// fpri es la derivada primera
// fpri es la derivada segunda
// f(x0) = f0
// f(xf) es el valor que se debe retornar en y.
function y=taylor(fpri, fseg, f0, x0, xf)
    ty = f0 + (fpri(x0)*xf-x0) + (fseg(x0))*(xf-x0^2/2)
endfunction