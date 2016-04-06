// *****************************************
// * Universidad Católica del Uruguay
// * Cálculo Numérico 2016
// * Laboratorio 3
// * Eduardo Senturión - Federico González
// *****************************************

// Esta función se utiliza para saber quienes son los participantes del grupo
function Grupo=AlumnosDelGrupo()
    Grupo = {};
    Grupo.Nombre1 = "Nombre del participante 1";
    Grupo.Nombre2 = "Nombre del participante 2";
    Grupo.Nombre3 = "Nombre del participante 3";
endfunction

// - a * (d / a) + d
// mirar la columna C y buscar el valor absoluto mas grande
// luego intercambiar el indice que tiene el maximo del valor absoluto
// luego de hacer el swap, obtener cero en el resto de C
// Implementacion de escalerizacion gaussiana
function y = escalerizacionGaussiana()
	A = [ 2  3  1 -2  -5 -3; 
		  1 -2  19 2   5 -9; 
		  8 -2  1  2   3  3; 
		  5 -6  20 10  5  3; 
	      3  8  5  32  2 12];

	[f,c] = size(A);

	for numCol = 1:c-2

		//Desde pivote hasta final filas		
		porcionColumnaActual = A([numCol:f],numCol);

		//El mayor absoluto		
		[pivote, idx] = max(abs(porcionColumnaActual));

		//Largo de la porcion actual --		
		[largo, ancho] = size(porcionColumnaActual);
		//--para saber el indice con respecto a toda la matriz		
		verdaderoIdx = idx + (f - largo);

		A = swapFila(A, verdaderoIdx, numCol);

		for numFila = numCol + 1:f

			A = escaleraCero(A, numCol, numFila);

			disp(A);
			x = input("Continuar");
		end 
	end

	y = A
endfunction

//// hace la escalerizacion recursiva, hay que agregar solamente la 
// parte de la escalerizacion
function A=intercambiarMaximo(A)
    [f c] = size(A)
    // u= maximo del vector; i= fila del maximo
    [u i]=max(A(1:f, 1))

    //intercambio la primer fila con la fila que tiene el 
        //valor mayor en la primer columna de la matriz
    A([1,i],:)=A([i,1],:)
    
    
    //aca hay que hacer la escalerizacion sobre toda la matriz!!!
    A(2:f,1)=0
    //aca termina la escalerizacion

// parte recursiva
    if (f > 2) then
        A(2:f, 2:c)=intercambiarMaximo(A(2:f,2:c))
    end

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


function A1 = escaleraCero(A, fAct, fEsc)
	cociente = - A(fEsc, fAct) / A(fAct, fAct);
	A(fEsc,:) = cociente * A(fAct,:) + A(fEsc,:);
	A1 = A
endfunction

function A1 = swapFila(A, f1, f2)
	A([f1,f2],:) = A([f2,f1],:);
	A1 = A
endfunction
