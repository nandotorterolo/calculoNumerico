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

// Determina la posición y la velocidad en el eje x
// p0: pocicion inicial
// v0: velocidad inicial
// alfa: angulo que se le pego a la pelota, ver imagen en la entrega
// n: cantidad de iteraciones
// e: efecto magnus
function [posX , velX]=posVelX(p0, v0, alfa, n, e)
    posX(1) = p0(1)
    velX(1) = v0 * cos(alfa)

    posX(2) = (velX(1) * h) + posX(1)
    velX(2) = (-b * h * velX(1) - e * h + m * velX(1)) / (m)
    
    posX(3) = velX(2) * 2 * h + posX(1)
    
    for i=3:n  
        velX(i) = (-b * 2 * h * velX(i-1) - e * 2 * h + m * velX(i-2)) / (m) 
        posX(i+1) = velX(i) * 2 * h + posX(i-1)
    end

    velX(i) = (-b * 2 * h * velX(i-1) - e* 2 * h + m * velX(i-2)) / (m)

endfunction

// Determina la posición y la velocidad en el eje Y
// p0: pocicion inicial
// v0: velocidad inicial
// alfa: angulo que se le pego a la pelota, ver imagen en la entrega
// n: cantidad de iteraciones
function [posY , velY]=posVelY(p0, v0, alfa, n)
    posY(1) = p0(2)
    velY(1) = v0 * tan(alfa)    
    
    posY(2) = (velY(1) * h) + posY(1)
    velY(2) = (m * velY(1) - b * h * velY(1)) / m
    
    posY(3) = velY(2) * 2 * h + posY(1)

    for i=3:n
        velY(i) = (m * velY(i-2) - b * 2 * h * velY(i-1)) / m
        posY(i+1) = velY(i) * 2 * h + posY(i-1)
    end

    velY(n+1) = (m * velY(n-2) - b * 2 * h * velY(n-1)) / m
endfunction

// Determina la posición y la velocidad en el eje Z
// p0: pocicion inicial
// v0: velocidad inicial
// alfa: angulo que se le pego a la pelota, ver imagen en la entrega
// n: cantidad de iteraciones
function [posZ , velZ]=posVelZ(p0, v0, alfa, n)
    
    posZ(1) = p0(3);
    velZ(1) = v0 * sin(alfa); 
    
    posZ(2) = (velZ(1) * h) + posZ(1)
    velZ(2) = (-b * h *velZ(1) + g * h * m + m * velZ(1)) / m 
    
    posZ(3) = velZ(2) * 2 * h + posZ(1)
        
    for i=3:n
        velZ(i) = (-b * 2 * h * velZ(i-1) + g * 2 * h * m + m * velZ(i-2)) / m 
        posZ(i+1) = velZ(i) * 2 * h + posZ(i-1)
    end
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

// Implementar un algoritmo que calcule y grafique la trayectoria de la pelota hasta que llegue a los palos
function parteDosNoConvergeGol()
    p0 = [-15, -15, 0]  // posicion de la pelota (x,y,z)
    n = 100             // cantidad iteraciones
    v0 = 8              // velocidad inicial es de 8 m/s
    alfa = -150           // angulo en grados
    e = -12              // efecto magnus
    
    [posX,velX] = posVelX(p0, v0, alfa,  n, e)
    // disp(posX)
    // disp(velX)
    
    [posY,velY] = posVelY(p0, v0, alfa,  n)
    // disp(posY)
    // disp(velY)
    
     [posZ,velZ] = posVelZ(p0, v0, alfa,  n)
    // disp(posZ)
    // disp(velZ)
    
endfunction



// Implementar un algoritmo que calcule y grafique la trayectoria de la pelota hasta que llegue a los palos
function parteDosConvergeGol()
    p0 = [0, -5, 0]     // posicion de la pelota (x,y,z)
    n = 50              // cantidad iteraciones
    v0 = 8              // velocidad inicial es de 8 m/s
    alfa = -200         // angulo en grados
    e = 12              // efecto magnus
    
    [posX,velX] = posVelX(p0, v0, alfa,  n, e)
    // disp(posX)
    // disp(velX)
    
    [posY,velY] = posVelY(p0, v0, alfa,  n)
    // disp(posY)
    // disp(velY)
    
     [posZ,velZ] = posVelZ(p0, v0, alfa,  n)
    // disp(posZ)
    // disp(velZ)
    

    param3d(posX, posY, posZ, flag=[1,4], ebox=[-5,5,-8,5,-1,10])
    e=gce() //the handle on the 3D polyline
    e.foreground=color('red');
    
    // horizontal axis
    drawaxis(x=-4:5,y=0,dir='u',tics='v')
       
endfunction


// Determine cuál fue la velocidad inicial
function parte4VelInicial()
    
    p0 = [1, -5, 0]     // posicion de la pelota (x,y,z)
    n = 50              // cantidad iteraciones
    v0 = 10             // velocidad inicial en m/s
    alfa =5             // angulo en grados
    e = 30;             // efecto en grados
    
    [posX,velX] = posVelX(p0, v0, alfa, n, e)
    vel0X = velocidadEjeX(p0, alfa, n, e, posX(n))
    disp("Velocidad inicial Eje X Discretizada = " + string(vel0X))
    //disp("Velocidad inicial Eje X Real = " + string(v0))
    
    [posY,velY] = posVelY(p0, v0, alfa, n)
    vel0Y = velocidadEjeY(p0, alfa, n, posY(n))
    disp("Velocidad inicial Eje Y Discretizada = " + string(vel0Y))

    [posZ,velZ] = posVelZ(p0, v0, alfa, n)
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


