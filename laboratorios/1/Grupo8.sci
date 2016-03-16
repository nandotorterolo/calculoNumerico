// Universidad Católica del Uruguay
// Cálculo Numérico
// Eduardo Senturión, Federico González
// Laboratorio 1


// Se debe cambiar X por su número
function nombre=nombreDeGrupo8()
    nombre="Grupo_Torterolo_DaRosa_Fernandez";
endfunction

// Se debe cambiar X por su número
function numero=numeroDeGrupo8()
    numero=8;
endfunction

// Se debe cambiar X por su número
function participantes=participantesGrupo8()
    participantes=['FernandoTorterolo', 'MartinDaRosa', 'PabloFernandez'];
endfunction

// Se debe cambiar X por su número
function jugada=estrategiaGrupo8(Tablero, miEquipo)
    jugada = ganaria(Tablero);
    if (jugada ~= -8) then
        return;
    end
    
    if (sum(abs(Tablero(:,4))) < 4) then
        jugada = 4;
        return;
    end
    jugada=alternativa(Tablero, miEquipo)
endfunction

// Retorno un valor entre 1,2,3,4,5,6,7 en el caso de ganar algun jugador, o -2 en otro caso
function jugada=ganaria(Tablero)
    jugada = -8;
    for (columna=1:1:7)
        // sumo la columna para validar que se pueda poner en esa columna
        suma = sum(abs(Tablero(:,columna)))+1;  // valor entre 1 y 7
        if (suma < 7) then
            JugadorUno = Tablero;
            JugadorUno(suma, columna) = 1;
            if (hayGanador(JugadorUno, columna, suma))  then
                jugada = columna
                return;
            end
            JugadorDos = Tablero;
            JugadorDos(suma, columna) = -1;
            if (hayGanador(JugadorDos, columna, suma))  then
                jugada = columna
                return;
            end
        end
    end
endfunction

// retorno un booleano que indica se hubo ganador para un Tablero, columna y fila dada.
// si hay un ganador corta por ciclo corto
function gana=hayGanador(Tablero, columna, fila)
    gana = %f;
    if(fila>=4) then
        ganaAux = ganaVertical(Tablero, columna, fila);
        if (ganaAux == %t) then
            gana = ganaAux;
            return;
        end
    end
    ganaAux = ganaHorizontal(Tablero, columna, fila);
    if (ganaAux == %t) then
        gana = ganaAux;
        return;
    end
    ganaAux = ganaDiagonal(Tablero, columna, fila);
    if (ganaAux == %t) then
        gana = ganaAux;
        return;
    end
endfunction

// Retorna booleano si hay ganador Diagonal
// Primero se buscan ganadores para jugador 1(izq a der), luego para gugador -1
function gana=ganaDiagonal(Tablero, columna, fila)
    gana = %f;
    seguidos = 0;
    f = fila
    c = columna
    while (f > 1 & c > 1)
        f = f - 1
        c = c - 1
    end
    // miro el tablero desde izquierda abajo, hasta derecha abajo.  para jugador 1
    while (f <= 6 & c <= 7)
        if (Tablero(f,c) == 1) then
            seguidos = seguidos + 1;
            if (seguidos == 4) then
                gana = %t;
                return;
            end
        else
            seguidos = 0;
        end
        f = f + 1
        c = c + 1
    end
    
    seguidos = 0;
    f = fila
    c = columna
    
    while (f < 6 & c > 1)
        f = f + 1
        c = c - 1
    end
    // miro el tablero desde izq arriba, hasta derecha abajo. para jugador 1
    while (f >= 1 & c <= 7)
        if (Tablero(f,c) == 1) then
            seguidos = seguidos + 1;
            if seguidos == 4 then
                gana = %t;
                return;
            end
        else
            seguidos = 0;
        end
        f = f - 1
        c = c + 1
    end
    
    seguidos = 0;
    f = fila
    c = columna
    while (f > 1 & c > 1)
        f = f - 1
        c = c - 1
    end
    // miro el tablero desde izquierda abajo, hasta derecha abajo.  para jugador -1
    while (f <= 6 & c <= 7)
        if (Tablero(f,c) == -1) then
            seguidos = seguidos + 1;
            if seguidos == 4 then
                gana = %t;
                return;
            end
        else
            seguidos = 0;
        end
        f = f + 1
        c = c + 1
    end
    
    seguidos = 0;
    f = fila
    c = columna
    while (f < 6 & c > 1)
        f = f + 1
        c = c - 1
    end
    // miro el tablero desde izquierda arriba, hasta derecha abajo. para jugador -1
    while (f >= 1 & c <= 7)
        if (Tablero(f,c) == -1) then
            seguidos = seguidos + 1;
            if seguidos == 4 then
                gana = %t;
                return;
            end
        else
            seguidos = 0;
        end
        f = f - 1
        c = c + 1
    end
endfunction

// Retorna booleano si hay ganador Horizontal
function gana=ganaHorizontal(Tablero, columna, fila)
    gana = %f;
    seguidos = 0;
    for (c=1:1:7)
        if (Tablero(fila,c) == 1) then
            seguidos = seguidos + 1;
            if seguidos == 4 then
                gana = %t;
                return;
            end
        else
            seguidos = 0;
        end
    end
    seguidos = 0;
    for (c=1:1:7)
        if (Tablero(fila,c) == -1) then
            seguidos = seguidos + 1;
            if seguidos == 4 then
                gana = %t;
                return;
            end
        else
            seguidos = 0;
        end
    end
    return;
endfunction

// Retorna booleano si hay ganador Vertical
function gana=ganaVertical(Tablero, columna, fila)
    gana = %f;
    seguidos = 0;
    for (f=fila:-1:1)
        if (Tablero(f,columna) == 1)  then
            seguidos = seguidos + 1;
            if seguidos == 4 then
                gana = %t;
                return;
            end
        else
            seguidos = 0;
        end
    end
    seguidos = 0;
    for (f=fila:-1:1)
        if (Tablero(f,columna) == -1)  then
            seguidos = seguidos + 1;
            if seguidos == 4 then
                gana = %t;
                return;
            end
        else
            seguidos = 0;
        end
    end
endfunction

function jugada=alternativa(Tablero, equipo)
    cont = 1;
    while (cont < 21)
        
        jugada = floor(rand() * 7) + 1 // //rand, (numero entre 0 y 1), * 7 (entre 0 y 7), mas 1. entre 1 y 7
        // malaJugada = si el numero es menor a 1, o es mayor a 7
        // fila Llena = 
        while (malaJugada(jugada) | filaLlena(Tablero, jugada))
            jugada = floor(rand() * 7) + 1
        end

        TableroNuevo = Tablero;
        fila = sum(abs(Tablero(:,jugada)))+1;
        TableroNuevo(fila,jugada) = equipo;
        jugadaDos = ganaria(TableroNuevo)
        if (jugadaDos == -2) then
            for (col=1:1:7)
                fila = sum(abs(Tablero(:,col)))+1;
                TableroNuevo(fila,col) = equipo;
                jugadaDos = ganaria(TableroNuevo)
                if (jugadaDos == -2) then
                    return;
                else 
                    TableroNuevo(fila,col) = 0;
                end
            end
        end
        cont = cont + 1;
    end
endfunction
