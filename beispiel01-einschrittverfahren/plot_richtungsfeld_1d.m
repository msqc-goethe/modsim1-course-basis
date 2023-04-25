function plot_richtungsfeld_1d(rhs, t, u)

% Initialisierung
du = zeros(length(u), length(t));
dt = ones(length(u), length(t));
for j=1:length(t)
    for i=1:length(u)
     	du(i,j) = rhs(u(i), t(j));
    end
end

% Plot
quiver(t,u,dt,du, 'color', [0.5,0.5,0.5]);
endfunction
