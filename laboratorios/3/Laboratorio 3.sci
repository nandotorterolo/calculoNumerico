    // Universidad Católica del Uruguay
// Cálculo Numérico
// Eduardo Senturión, Federico González
// Laboratorio 3



 // pasar A=[2 3,3 2] ; b= [1,2]
function x=escalerizarGauss (A,b)
    x(2)= (-1*(A(1,1)/A(2,1)*b(2)) + b(1)) / (-1*(A(1,1)/A(2,1)*A(2,2)) + A(1,2))
    x(1)= (b(1)-1*A(1,2)*x(2))/(A(1,1))
    
endfunction





    //intercambio la primer fila con la fila que tiene el 
    //valor mayor en la primer columna de la matriz
//function [A,b]=intercambiarMaximo(A, b)
function [A,b]=intercambiarMaximoAB(A, b)
    [f c] = size(A)
    //disp(A(1:f, 1))
    // u= maximo del vector; i= fila del maximo
    [u i]=max(A(1:f, 1))
    //disp([u i])
    //intercambio la primer fila con la fila que tiene el 
    //valor mayor en la primer columna de la matriz
    A([1,i],:)=A([i,1],:)
    b([1,i])=b([i,1])
    disp(b)
endfunction

function A=intercambiarMaximo(A)
    [f c] = size(A)
    //disp(A(1:f, 1))
    //disp(f, c)
    // u= maximo del vector; i= fila del maximo
    [u i]=max(A(1:f, 1))
    //disp([u i])
    //intercambio la primer fila con la fila que tiene el 
        //valor mayor en la primer columna de la matriz
    A([1,i],:)=A([i,1],:)
    //aca hay que hacer la escalerizacion
    A(2:f,1)=0
    //aca termina la escalerizacion

// parte recursiva
    if (f > 2) then
        A(2:f, 2:c)=intercambiarMaximo(A(2:f,2:c))
    end

endfunction

