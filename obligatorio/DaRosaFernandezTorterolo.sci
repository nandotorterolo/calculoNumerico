// Obligatorio
// Calculo numérico, Primer Semestre 2016
// Facultad de ingeniería - Universidad Católica del Uruguay
// Eduardo Senturión - Carlos González 
// Da Rosa - Fernandez- Torterolo

// constantes
g = 9.8           //  gravedad de 9.81 m/s^2
m = 0.450         //  masa es 500 gramos
b = 1.71* 10^(-5) //  viscosidad del aire https://es.wikipedia.org/wiki/Aire
h = 0.01          //  instante de tiempo en s

// Dibujar la cancha de rubby, y uno de los arco
// https://help.scilab.org/docs/5.3.2/fr_FR/plot3d.html
function dibujarCancha()
    
    // Dimensiones 
    x = 0:70; 
    y = 0:100;
    
    // Matriz de la cancha con sus dimiensiones
    z = zeros(length(x), length(y));
    
    // Dibuja la cancha y  el arco
    plot3d(x, y, z, leg="x@Profundidad (Y)@Altura (Z)",flag=[-3,1,0], ebox=[0,70,0,100,-60,0]);

    // dibujarArco()

endfunction

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

    disp(i)
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


// Implementar un algoritmo que calcule y grafique la trayectoria de la pelota hasta que llegue a los palos
function parteDosNoConvergeGol()
    p0 = [-15, -15, 0]  // posicion de la pelota (x,y,z)
    n = 100             // cantidad iteraciones
    v0 = 8              // velocidad inicial es de 8 m/s
    alfa = -150           // angulo en grados
    e = -12              // efecto magnus
    
    [posX,velX] = posVelX(p0, v0, alfa,  n, e)
    // disp(posX)
    disp(velX)
    
    [posY,velY] = posVelY(p0, v0, alfa,  n)
    // disp(posY)
    disp(velY)
    
     [posZ,velZ] = posVelZ(p0, v0, alfa,  n)
    // disp(posZ)
    disp(velZ)
    
endfunction



// Implementar un algoritmo que calcule y grafique la trayectoria de la pelota hasta que llegue a los palos
function parteDosConvergeGol()
    p0 = [0, -5, 0]  // posicion de la pelota (x,y,z)
    n = 50             // cantidad iteraciones
    v0 = 8              // velocidad inicial es de 8 m/s
    alfa = -200           // angulo en grados
    e = 12              // efecto magnus
    
    [posX,velX] = posVelX(p0, v0, alfa,  n, e)
    disp(posX)
    // disp(velX)
    
    [posY,velY] = posVelY(p0, v0, alfa,  n)
    disp(posY)
    // disp(velY)
    
     [posZ,velZ] = posVelZ(p0, v0, alfa,  n)
    disp(posZ)
    // disp(velZ)
    
endfunction


