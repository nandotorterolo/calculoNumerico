// Obligatorio
// Calculo numérico, Primer Semestre 2016
// Facultad de ingeniería - Universidad Católica del Uruguay
// Eduardo Senturión - Carlos González 
// Da Rosa - Fernandez- Torterolo

// constantes
g = 9.8           //  gravedad  m/s^2
m = 0.450         //  masa en gramos
b = 1.71* 10^(-5) //  viscosidad del aire https://es.wikipedia.org/wiki/Aire
h = 0.01          //  instante de tiempo en s


// Determina la velocidad en el eje X utilizando derivada central o cociente incremental
// vant: valor anterior para el uso de derivada central
// vant = vsig: valor para utilizar cociente incremental
// mult: 1 para cociente incremental, 2 para derivada central
function res=funcVelX(vant, vsig, mult, e)
    res = (-b * h * mult * vsig - e * mult * h + m * vant) / (m)
endfunction

// Determina la velocidad en el eje Y utilizando derivada central o cociente incremental
// vant: valor anterior para el uso de derivada central
// vant = vsig: valor para utilizar cociente incremental
// mult: 1 para cociente incremental, 2 para derivada central
function res=funcVelY(vant, vsig, mult, e)
    res=( - b * mult * h * vsig + m * vant) / m
endfunction

// Determina la velocidad en el eje Z utilizando derivada central o cociente incremental
// vant: valor anterior para el uso de derivada central
// vant = vsig: valor para utilizar cociente incremental
// mult: 1 para cociente incremental, 2 para derivada central
function res=funcVelZ(vant, vsig, mult, e)
    res = (-b * mult * h * vsig + m * g * mult * h + m * vant) / m 
endfunction




// Determina la posición y la velocidad en el eje de trabajo
// p0: pocicion inicial
// v0: velocidad inicial
// n: cantidad de iteraciones
// e: efecto magnus
// velFunc: función que calcula la velocidad
function [pos , vel]=posVel(p0, v0, n, e, velFunc)
    pos(1) = p0
    vel(1) = v0 

    pos(2) = (vel(1) * h) + pos(1)
    vel(2) = velFunc(vel(1), vel(1), 1, e) //usa cociente incremental
    
    pos(3) = vel(2) * 2 * h + pos(1)
    
    for i=3:n  
        vel(i) = velFunc(vel(i-1), vel(i-2), 2, e) //usa derivada central
        pos(i+1) = vel(i) * 2 * h + pos(i-1)
    end
    vel(i) = velFunc(vel(i-1), vel(i-2), 2, e)    

endfunction




// Determine velocidad inicial en Eje X
// po pocision inicial
// pf pocision final
// alfa: angulo que se le pego a la pelota, ver imagen en la entrega
// n cantidad de iteraciones
// e: efecto magnus
function vel0X = velocidadEjeX(p0, alfa, n, e, pf)   

    A = zeros(n+1, n+1)  
    A(1, 1) = 1
    A(2, 2) = 1
    A(2, 1) = -1
    A(2, n+1) = -h

    for k = 3:n
        A(k , k-2) = 2 * b * h - 2 * m
        A(k , k-1) = 4 * m
        A(k , k) =( b * h + 2 * m) *-1 
    end

    A(n + 1, n) = 1

    sol = zeros(n+1,1)
    for i=3:n+1
        sol(i,1) = 2 * e * h^2
    end
    sol(1) = p0(1)  
    sol(n+1) = pf  
    sol = (A\sol)
    vel0X = sol(n+1) / cos(alfa)

endfunction

function vel0Y = velocidadEjeY(p0, alfa, n, pf)   

    A = zeros(n+1, n+1)   
    A(1, 1) = 1
    A(2, 2) = 1
    A(2, 1) = -1
    A(2, n+1) = -h

    for k = 3:n
        A(k , k-2) = 2 * b * h -2 * m
        A(k , k-1) = 4 * m
        A(k , k) =(b * h + 2 * m ) *-1 
    end

    A(n + 1, n) = 1
    sol = zeros(n+1,1)  // no es necesario setear vector solucion, ver ecuacion en documento
    sol(1) = p0(2)
    sol(n+1) = pf
    sol = (A\sol)
    vel0Y = sol(n+1) / tan(alfa)

endfunction

function vel0Z = velocidadEjeZ(p0, alfa, n, pf)   
    A = zeros(n+1, n+1)  
    A(1, 1) = 1
    A(2, 2) = 1
    A(2, 1) = -1
    A(2, n+1) = -h

    for k = 3:n
        A(k , k-2) = 2 * b * h - 2 * m
        A(k , k-1) = 4 * m
        A(k , k) =( b * h + 2 * m ) * -1 
    end
    A(n + 1, n) = 1
    sol = zeros(n+1,1)
    for i=3:n+1
        sol(i,1) = -2 * m * g * (h^2)
    end
    sol(1) = p0(3)
    sol(n+1) = pf
    sol = (A\sol)
    vel0Z = sol(n+1) / sin(alfa)
endfunction


function calculaTrayectoria(p0, n, v0, alfa, e)
    vx = v0 * cos(alfa)
    [posX,velX] = posVel(p0(1), vx, n, e, funcVelX)
    // disp(posX)
    // disp(velX)
    
    vy = v0 * tan(alfa)
    [posY,velY] = posVel(p0(2), vy, n, e, funcVelY)
    // disp(posY)
    // disp(velY)
    
    vz = v0 * sin(alfa)    
     [posZ,velZ] = posVel(p0(3), vz, n, e, funcVelZ)
    // disp(posZ)
    // disp(velZ)
    
    param3d(posX, posY, posZ, flag=[1,4], ebox=[-5,5,-8,5,-1,10])
    e=gce() //the handle on the 3D polyline
    e.foreground=color('red');
    
    // horizontal axis
    drawaxis(x=-4:5,y=0,dir='u',tics='v')
endfunction

// Implementar un algoritmo que calcule y grafique la trayectoria de la pelota hasta que llegue a los palos
function parteDosNoConvergeGol()
    p0 = [-15, -15, 0]  // posicion de la pelota (x,y,z)
    n = 100             // cantidad iteraciones
    v0 = 8              // velocidad inicial es de 8 m/s
    alfa = -150           // angulo en grados
    e = -12              // efecto magnus
    
    calculaTrayectoria(p0, n, v0, alfa, e)
    
endfunction



// Implementar un algoritmo que calcule y grafique la trayectoria de la pelota hasta que llegue a los palos
function parteDosConvergeGol()
    p0 = [0, -5, 0]     // posicion de la pelota (x,y,z)
    n = 50              // cantidad iteraciones
    v0 = 8              // velocidad inicial es de 8 m/s
    alfa = -200         // angulo en grados
    e = 12              // efecto magnus
    
    calculaTrayectoria(p0, n, v0, alfa, e)
       
endfunction


// Determine cuál fue la velocidad inicial
function parte4VelInicial()
    
    p0 = [1, -5, 0]     // posicion de la pelota (x,y,z)
    n = 50              // cantidad iteraciones
    v0 = 10             // velocidad inicial en m/s
    alfa =5             // angulo en grados
    e = 30;             // efecto en grados
    
    vx = v0 * cos(alfa)
    disp("vx" +string(vx))
    [posX,velX] = posVel(p0(1), vx, n, e, funcVelX)
    vel0X = velocidadEjeX(p0, alfa, n, e, posX(n))
    disp("Velocidad inicial Eje X Discretizada = " + string(vel0X))
    disp("Velocidad inicial Eje X Real = " + string(v0))
    
    vy = v0 * tan(alfa)
    disp("vy" +string(vy))
    [posY,velY] = posVel(p0(2), vy, n, e, funcVelY)
    vel0Y = velocidadEjeY(p0, alfa, n, posY(n))
    disp("Velocidad inicial Eje Y Discretizada = " + string(vel0Y))

    vz = v0 * sin(alfa)
    disp("vx" +string(vz))
    [posZ,velZ] = posVel(p0(3), vz, n, e, funcVelZ)
    vel0Z = velocidadEjeZ(p0, alfa, n, posZ(n))
    disp("Velocidad inicial Eje Z Discretizada = " + string(vel0Z))    
    
    
    disp(posX(n))
    disp(posY(n))
    disp(posZ(n))
//    disp("Velocidad inicial Eje Y Real = " + string(v0))
//    disp("Velocidad inicial Eje Y Error absoluto = " + string(abs(v0 - vel0Y)))
    
     // vel0X = sol(n+1) / cos(alfa)
     // vel0Y = sol(n+1) / tan(alfa)
     // vel0Z = sol(n+1) / sin(alfa)
    
endfunction


