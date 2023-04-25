
global Coeff =[2 1; 1 3];  
ustat = [Coeff(2,1) / Coeff(2,2); Coeff(1,1)/Coeff(1,2)]
u0=[0.1; 1];   % Falls ein Kommando mit Semikolon beendet wird, erfolgt keine Ausgabe.

function udot=f_rhs(u, t)
    global Coeff
    udot = zeros(2,1);
      
    udot(1) = u(1)*(Coeff(1,1) - Coeff(1,2)*u(2));
    udot(2) = - u(2)*(Coeff(2,1)- Coeff(2,2)*u(1));
endfunction

times = linspace(0.0, 20.0, 500);

numsol  = lsode (@(y,t) f_rhs(y,4,t), u0, times);

hold on   % 
xlabel('Zeit t')
ylabel('Population')
plot(times, numsol(:,1), 'color', 'black')
plot(times, numsol(:,2), 'color', 'red')

hold on
xlabel('Hasen')
ylabel('Fuechse')
plot(numsol(:,1), numsol(:,2), 'color', 'blue')
plot(ustat(1), ustat(2), 'color', 'black')
plot(u0(1), u0(2), 'color', 'black')


% Erstelle N x N Raster
N = 17 % 17 Punkte = 16 Intervalle

xmax = max(numsol(:,1))
ymax = max(numsol(:,2))

xaxis= linspace(0.0, xmax, N);
yaxis= linspace(0.0, ymax, N);

% Initialisierung
dxRaster = zeros(N);
dyRaster = zeros(N);

% Erstelle eine Matrix mit i,j Indizierung
for i=1:length(yaxis)
for j=1:length(xaxis)
    f = f_rhs([xaxis(j); yaxis(i)], 0);
    dxRaster(i,j) = f(1);
    dyRaster(i,j) = f(2);
end
end

% Eine weitere Lösung zum Anfangswert (0.5, 1)
numsol2 = lsode (@(y,t) f_rhs(y,4,t), [0.5; 1], times); 
 
% Eigentlicher Plot mit quiver (s. help quiver)
hold on
xlabel('x')
ylabel('y')
title ("Richtungsfeld dy/dx ");
quiver (xaxis, yaxis, dxRaster, dyRaster);
plot(numsol(:,1), numsol(:,2), 'color', 'black')
plot(numsol2(:,1), numsol2(:,2), 'color', 'green')
plot(ustat(1), ustat(2), 'color', 'black')

help plot




