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
//Entrada: 
// A - [n x n] Double
// b - [n x 1] Double
function y = escalerizacionGaussiana(A, b)
    
    M = cat(2,A,b) // concatenation of the input arguments A,b
//    disp(M)
    
    [f,c] = size(M);

	for numCol = 1:c-2

		for numFila = numCol + 1:f

			M = escaleraCero(M, numCol, numFila);

//			disp(M);
//			x = input("Continuar");
		end 
	end

	y = M
    
endfunction

// Implementacion de escalerizacion utilizando pivot
//Entrada: 
// A - [n x n] Double
// b - [n x 1] Double
function y = escalerizacionPivot(A, b)
    M = cat(2,A,b) // concatenation of the input arguments A,b
//    disp(M)
    
    [f,c] = size(M);

	for numCol = 1:c-2

		//Desde pivote hasta final filas		
		porcionColumnaActual = M([numCol:f],numCol);

		//El mayor absoluto		
		[pivote, idx] = max(abs(porcionColumnaActual));

		//Largo de la porcion actual --		
		[largo, ancho] = size(porcionColumnaActual);
		//--para saber el indice con respecto a toda la matriz		
		verdaderoIdx = idx + (f - largo);

		M = swapFila(M, verdaderoIdx, numCol);

		for numFila = numCol + 1:f

			M = escaleraCero(M, numCol, numFila);

//			disp(M);
//			x = input("Continuar");
		end 
	end

	y = M
endfunction

// Implementacion de resolucion del sistema Ax = b utilizando factorizacion LU
function y = resolucionLU(A, b)
    [L, U] = LU(A);
    y = struct("L", L, "U", U) // [L,U];
endfunction

// Implementacion de sistema LU
// A - [n x n] Double
function [L, U] = LU(A, b)
    n = size(A);
    if( n(1) <> n(2) ) then
        error("!!!ERROR:  No se respeto entrada, A - [n x n] Double!!!")
    else
        n = n(1)
    end
    U1 = A
    L1 = eye(n,n)             // Inicializa L como identidad
    for k = 1:n-1
        for j = k+1:n
            L1(j,k) = U1(j,k) / U1(k,k)            // Multiplicadores
            U1(j,:) = U1(j,:) - L1(j,k) * U1(k,:)   // Fila j = Fila j - L(jk)*Fila k
        end
    end
    L= L1
    U= U1
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


function test1EscGaussiana()
    A=[1 3 4;2 7 9;9 8 7]
    b=[2;6;3]
    y = escalerizacionGaussiana(A,b)
    disp(y);
endfunction

function test1EscPivot()
    A=[1 3 4;2 7 9;9 8 7]
    b=[2;6;3]
    y = escalerizacionPivot(A,b)
    disp(y);
endfunction

function test1ResolucionLU()
    A = [4 5 7; 5 3 6; 0 7 5];
    b=[0;0;0] // b no tiene importancia
    disp("A:") 
    disp(A)
    y = resolucionLU(A,b)
    disp("L:")
    disp(y.L);
    disp("U:")
    disp(y.U);
    disp("L*U  deberia ser == A:")
    disp(y.L * y.U);
endfunction


