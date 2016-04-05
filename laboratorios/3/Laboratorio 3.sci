    // Universidad Católica del Uruguay
// Cálculo Numérico
// Eduardo Senturión, Federico González
// Laboratorio 3



 // pasar A=[2 3,3 2] ; b= [1,2]
function x=escalerizarGauss (A,b)
    x(2)= (-1*(A(1,1)/A(2,1)*b(2)) + b(1)) / (-1*(A(1,1)/A(2,1)*A(2,2)) + A(1,2))
    x(1)= (b(1)-1*A(1,2)*x(2))/(A(1,1))
    
endfunction
