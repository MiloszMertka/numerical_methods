f1 = @(x) x.*exp(x);
f2 = @(x) sqrt(1 - x.^2);

h = 0.01;
a = -1;
b = 1;

f1_solution = 2 / exp(1);
f2_solution = pi / 2;

disp("Funkcja f1");
disp("Kwadratura prostokatow: " + kw_prost(f1, a, b));
disp("Kwadratura trapezow: " + kw_trap(f1, a, b));
disp("Kwadratura Simpsona: " + kw_simpson(f1, a, b));
disp("Kwadratura 3/8: " + kw_38(f1, a, b));

disp("Funkcja f2");
disp("Kwadratura prostokatow: " + kw_prost(f2, a, b));
disp("Kwadratura trapezow: " + kw_trap(f2, a, b));
disp("Kwadratura Simpsona: " + kw_simpson(f2, a, b));
disp("Kwadratura 3/8: " + kw_38(f2, a, b));

headers = ["Rząd", "Przybliżona wartość całki"];
results_f1 = [];
results_f2 = [];
all_errors_f1 = [];
all_errors_f2 = [];

for d = 1 : 4
    [sum_f1, steps_f1] = calk_zloz(f1, a, b, h, d);
    [sum_f2, steps_f2] = calk_zloz(f2, a, b, h, d);
    results_f1 = [results_f1; [d, sum_f1]];
    results_f2 = [results_f2; [d, sum_f2]];

    errors_f1 = [];
    for i = 1 : length(steps_f1)
        errors_f1 = [errors_f1 abs(f1_solution - steps_f1(i))];
    end

    errors_f2 = [];
    for i = 1 : length(steps_f2)
        errors_f2 = [errors_f2 abs(f2_solution - steps_f2(i))];
    end

    all_errors_f1 = cat(1, all_errors_f1, errors_f1);
    all_errors_f2 = cat(1, all_errors_f2, errors_f2);
end

disp("Funkcja f1")
table = array2table(results_f1, "VariableNames", headers);
disp(table);

disp("Funkcja f2")
table = array2table(results_f2, "VariableNames", headers);
disp(table);

% wykres dla f1
grid on;
hold on;
title("Wykres zmiany błędu bezwględnego dla funkcji f1");
for d = 1 : 4
    y = log10(all_errors_f1(d,:));
    x = logspace(-1, 2, length(y));
    loglog(x, y);
end
legend("Rzad 1", "Rzad 2", "Rzad 3", "Rzad 4")
hold off;

% wykres dla f2
figure;
grid on;
hold on;
title("Wykres zmiany błędu bezwględnego dla funkcji f2");
for d = 1 : 4
    y = log10(all_errors_f2(d,:));
    x = logspace(-1, 2, length(y));
    loglog(x, y);
end
legend("Rzad 1", "Rzad 2", "Rzad 3", "Rzad 4")
hold off;

% wykresy bledow w zaleznosci od h
figure;
hold on;
title("Wykres bledu bezwzglednego w funkcji kroku calkowania h dla zadanej funkcji f1");
for d = 1 : 4
    errors_f1 = [];
    hn = [];
    for hi = 0.001 : 0.001 : 1
        [sum_f1, s] = calk_zloz(f1, a, b, hi, d);
        errors_f1 = [errors_f1; abs(f1_solution - sum_f1)];
        hn = [hn; hi];
    end
    y = log10(errors_f1);
    semilogy(hn, y);
end
legend("Rzad 1", "Rzad 2", "Rzad 3", "Rzad 4")
hold off;

figure;
hold on;
title("Wykres bledu bezwzglednego w funkcji kroku calkowania h dla zadanej funkcji f2");
for d = 1 : 4
    errors_f2 = [];
    hn = [];
    for hi = 0.001 : 0.001 : 1
        [sum_f2, s] = calk_zloz(f2, a, b, hi, d);
        errors_f2 = [errors_f2; abs(f2_solution - sum_f2)];
        hn = [hn; hi];
    end
    y = log10(errors_f2);
    semilogy(hn, y);
end
legend("Rzad 1", "Rzad 2", "Rzad 3", "Rzad 4")
hold off;
