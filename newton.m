clear; clc; close all;

x_data = [-0.9; -0.2; 0.3; 0.7; 1.5; 2.2; 3.2; 3.9; 4.5; 5.1; 5.7; 6.2];
y_data = [1.841; 4.872; 4.757; 3.873; 1.625; 1.128; 7.048; 18.689; 35.375; 59.621; 92.723; 128.008];

fprintf('--- MÉTODO DE NEWTON (Diferencias Divididas) ---\n');
x_eval = input('¿En qué valor de x quieres evaluar? ');

n = length(x_data);
D = zeros(n, n);
D(:,1) = y_data;

for j = 2:n
    for i = 1:n-j+1
        D(i,j) = (D(i+1,j-1) - D(i,j-1)) / (x_data(i+j-1) - x_data(i));
    end
end

eval_newton = @(val) D(1,1);
for i = 1:n-1
    termino = @(val) D(1, i+1);
    for j = 1:i
        temp_f = termino;
        termino = @(val) temp_f(val) .* (val - x_data(j));
    end
    ant_f = eval_newton;
    eval_newton = @(val) ant_f(val) + termino(val);
end

N_eval = eval_newton(x_eval);

xp = linspace(min(x_data), max(x_data), 100);
figure('Name', 'Interpolación Newton', 'Color', 'w');
plot(x_data, y_data, 'ro', 'MarkerFaceColor', 'r'); hold on;
plot(xp, eval_newton(xp), 'm-', 'LineWidth', 1.5);
plot(x_eval, N_eval, 'ks', 'MarkerSize', 12, 'LineWidth', 2);
grid on;
title(['Newton: f(' num2str(x_eval) ') = ' num2str(N_eval)]);
legend('Puntos Tabla', 'Polinomio Newton', 'Punto Evaluado');