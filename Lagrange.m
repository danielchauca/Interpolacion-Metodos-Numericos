clear; clc; close all;

x_data = [-0.9; -0.2; 0.3; 0.7; 1.5; 2.2; 3.2; 3.9; 4.5; 5.1; 5.7; 6.2];
y_data = [1.841; 4.872; 4.757; 3.873; 1.625; 1.128; 7.048; 18.689; 35.375; 59.621; 92.723; 128.008];

fprintf('--- MÉTODO DE LAGRANGE ---\n');
x_eval = input('¿En qué valor de x quieres evaluar? ');

n = length(x_data);
L_eval = 0;

for i = 1:n
    Li = 1;
    for j = 1:n
        if i ~= j
            Li = Li * (x_eval - x_data(j)) / (x_data(i) - x_data(j));
        end
    end
    L_eval = L_eval + y_data(i) * Li;
end

xp = linspace(min(x_data), max(x_data), 100);
yp = zeros(size(xp));
for k = 1:length(xp)
    val = 0;
    for i = 1:n
        Li_p = 1;
        for j = 1:n
            if i ~= j
                Li_p = Li_p * (xp(k) - x_data(j)) / (x_data(i) - x_data(j));
            end
        end
        val = val + y_data(i) * Li_p;
    end
    yp(k) = val;
end

figure('Name', 'Interpolación Lagrange', 'Color', 'w');
plot(x_data, y_data, 'ro', 'MarkerFaceColor', 'r'); hold on;
plot(xp, yp, 'b-', 'LineWidth', 1.5);
plot(x_eval, L_eval, 'ks', 'MarkerSize', 12, 'LineWidth', 2);
grid on;
title(['Lagrange: f(' num2str(x_eval) ') = ' num2str(L_eval)]);
legend('Puntos Tabla', 'Polinomio Lagrange', 'Punto Evaluado');