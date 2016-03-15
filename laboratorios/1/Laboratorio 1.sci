// Universidad Católica del Uruguay
// Cálculo Numérico
// Eduardo Senturión, Federico González
// Laboratorio 1

function cuatroEnLinea(estrategia1, estrategia2, nombre1, nombre2)
    Tablero = zeros(6,7);
    eqActual = 1;
    fin = %f;
    tiempo = 1

    printf('=====================================\n');
    printf('= Universidad Católica del Uruguay. =\n');
    printf('=         Cuatro en línea           =\n');
    printf('=====================================\n\n');
    
    for i = 1:1:37
        sleep(tiempo);
        printf('=');
    end
    
    printf('\n\n');
    
    imprimirTablero(Tablero)
    
    printf('\n   ===> El juego comienza\n');
    while (~tableroLleno(Tablero) & ~fin)
        printf('   ===> Turno %s:\n', nombreEquipo(eqActual, nombre1, nombre2))
        
        if eqActual == 1 then
            jugada = estrategia1(Tablero, eqActual);
        else
            jugada = estrategia2(Tablero, eqActual);
        end
        
        if (malaJugada(jugada)) then
            printf('Equipo %s, no digitó un valor correcto.\n', nombreEquipo(eqActual, nombre1, nombre2));
            printf('Gana el equipo %s', nombreEquipo(-eqActual));
            fin = %t;
        else 
            if (filaLlena(Tablero, jugada)) then
                printf('Equipo %s, intenta poner una ficha en una columna llena.\n', nombreEquipo(eqActual, nombre1, nombre2));
                printf('Gana el equipo %s', nombreEquipo(-eqActual, nombre1, nombre2));
                fin = %t;
            else
                siguiente = sum(abs(Tablero(:,jugada)))+1;
                Tablero(siguiente, jugada) = eqActual;
                sleep(5*tiempo)
                printf('\n   Jugada realizada %i \n\n\n', jugada)
                imprimirTablero(Tablero);
                if (victoriaActual(Tablero, jugada, siguiente)) then
                     printf('¡¡¡¡¡¡¡ Gana el equipo %s !!!!!!', nombreEquipo(eqActual, nombre1, nombre2));
                     fin = %t;
                end
            end
        end
        eqActual = -eqActual;
    end
    
    if (~fin) then
        printf('¡¡¡¡¡¡¡ El partido termina empatado !!!!!!');
    end
endfunction

function gana=victoriaActual(Tablero, jugada, siguiente)
    gana = %f;
    for x = 0:1:1
        for y = 0:1:1
            for delta = -3:1:0
                if (abs(sumarValores(Tablero, jugada, siguiente, x, y, delta))==4) then
                    gana = %t;
                    return;
                end
            end
        end
    end
endfunction

function suma=sumarValores(Tablero, jugada, siguiente, x, y, delta)
    
    suma = 0;
    if ((x == 0) & (y == 0)) then
        x = -1;
        y = 1;
    end

    for i = delta:1:delta+3
        valx = siguiente + i*x;
        valy = jugada + i*y;
        
        if valx < 1 | valx > 6 | valy < 1 | valy > 7 then
            return;
        end
        
        suma = suma + Tablero(valx, valy);
    end
endfunction

function mala=malaJugada(jugada)
    mala = (jugada ~= 1 & jugada ~= 2 & jugada ~= 3 & jugada ~= 4 & jugada ~= 5 & jugada ~= 6 & jugada ~= 7);
endfunction

function llena = filaLlena(Tablero, jugada)
    llena = sum(abs(Tablero(:, jugada)))==6;
endfunction

function lleno=tableroLleno(Tablero)
    lleno = (sum(abs(Tablero)) == 6*7);
endfunction

function nombre=nombreEquipo(i, nombre1, nombre2)
    if i == 1 then
        nombre = nombre1;
    else
        nombre = nombre2;
    end
endfunction

function imprimirTablero(Tablero)
    printf('       /  1  2  3  4  5  6  7 \n');
    
    for (i= 1:1:6)
        fila = 7-i;
        printf('       %i  ', fila);
        
        for (j=1:1:7)
            if Tablero(fila,j) == 0 then
                printf(' . ');
            else 
                if Tablero(fila,j) == 1 then
                    printf(' o ');
                else
                    printf(' x ');
                end
            end   
        end
        
        printf('\n');
    end
endfunction

function jugada=pregunta(Tablero, miEquipo)
    printf('Ingrese jugada: ');
    jugada=mscanf("%f");
endfunction

function jugada=azar(Tablero, miEquipo)
    jugada = floor(rand() * 7) + 1
    while (malaJugada(jugada) | filaLlena(Tablero, jugada))
        jugada = floor(rand() * 7) + 1
    end
endfunction

