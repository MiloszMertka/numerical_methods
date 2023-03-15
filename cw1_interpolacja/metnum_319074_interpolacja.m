x = linspace(-1, 1, 100);
f = @(x) 1./(1+25*x.^2);

plots_colors = ["b-", "g-", "r-", "y-", "k-"];
nodes_colors = ['b*', "g*", "r*", "y*", "k*"];

absolute_errors = [];
relative_errors = [];

% interpolacja
interpolation_figure = figure('Name', 'Interpolacja', 'NumberTitle', 'off');
figure(interpolation_figure);

% interpolacja Lagrangea
subplot(2, 1, 1);
hold on;
plot(x, f(x), 'DisplayName', 'Oryginalna funkcja');
for n = 2 : 2 : 8
    xn = linspace(-1, 1, n + 1);
    yn = f(xn);

    max_absolute_error = intmin;
    max_relative_error = intmin;
    fn_lagrange = [];
    for i = 1 : 100
        fn_lagrange = [fn_lagrange lagr_int(xn, yn, x(i))];
        absolute_error = abs(fn_newton(i) - f(x(i)));

        if (absolute_error > max_absolute_error)
            max_absolute_error = absolute_error;
        end

        if (f(x(i)) >= 10e-4)
            relative_error = absolute_error / f(x(i));
            if (relative_error > max_relative_error)
                max_relative_error = relative_error;
            end
        end
    end
    absolute_errors = [absolute_errors; ["Interpolacja Lagrangea", n, "-", max_absolute_error]];
    relative_errors = [relative_errors; ["Interpolacja Lagrangea", n, "-", max_relative_error]];

    plot(xn, yn, nodes_colors(n / 2), 'DisplayName', sprintf('Węzły interpolacji n = %d', n));
    plot(x, fn_lagrange, plots_colors(n / 2), 'DisplayName', sprintf('Interpolacja Lagrangea n = %d', n));
end
legend
hold off;

% interpolacja Newtona
subplot(2, 1, 2);
hold on;
plot(x, f(x), 'DisplayName', 'Oryginalna funkcja');
for n = 2 : 2 : 8
    xn = linspace(-1, 1, n + 1);
    yn = f(xn);

    max_absolute_error = intmin;
    max_relative_error = intmin;
    fn_newton = [];
    for i = 1 : 100
        fn_newton = [fn_newton newton_int(xn, yn, x(i))];
        absolute_error = abs(fn_newton(i) - f(x(i)));

        if (absolute_error > max_absolute_error)
            max_absolute_error = absolute_error;
        end

        if (f(x(i)) >= 10e-4)
            relative_error = absolute_error / f(x(i));
            if (relative_error > max_relative_error)
                max_relative_error = relative_error;
            end
        end
    end
    absolute_errors = [absolute_errors; ["Interpolacja Newtona", n, "-", max_absolute_error]];
    relative_errors = [relative_errors; ["Interpolacja Newtona", n, "-", max_relative_error]];

    plot(xn, yn, nodes_colors(n / 2), 'DisplayName', sprintf('Węzły interpolacji n = %d', n));
    plot(x, fn_newton, plots_colors(n / 2), 'DisplayName', sprintf('Interpolacja Newtona n = %d', n));
end
legend
hold off;

% aproksymacja
approximation_figure = figure('Name', 'Aproksymacja', 'NumberTitle', 'off');
figure(approximation_figure);

ax = [subplot(3, 1, 1), subplot(3, 1, 2), subplot(3, 1, 3)];

axes(ax(1));
title('Aproksymacja dla k = n + 2');
axes(ax(2));
title('Aproksymacja dla k = 2n');
axes(ax(3));
title('Aproksymacja dla k = 3n');

for n = 3 : 2 : 11
    if (n == 9)
        continue
    end

    k = [(n + 2), (2 * n), (3 * n)];
    for i = 1 : length(k)
        xn = linspace(-1, 1, k(i));
        yn = f(xn);
        
        p = polyfit(xn, yn, n);
        wn = polyval(p, x);

        max_absolute_error = intmin;
        max_relative_error = intmin;
        for j = 1 : length(wn)
            absolute_error = abs(wn(j) - f(x(j)));
    
            if (absolute_error > max_absolute_error)
                max_absolute_error = absolute_error;
            end

            if (f(x(j)) >= 10e-4)
                relative_error = absolute_error / f(x(j));
                if (relative_error > max_relative_error)
                    max_relative_error = relative_error;
                end
            end
        end

        absolute_errors = [absolute_errors; ["Aproksymacja", n, k(i), max_absolute_error]];
        relative_errors = [relative_errors; ["Aproksymacja", n, k(i), max_relative_error]];

        axes(ax(i));
        hold on;
        plot(x, wn, plots_colors((n - 1) / 2), 'DisplayName', sprintf('Aproksymacja n = %d', n));
        hold off;
    end
end

for i = 1 : length(ax)
    axes(ax(i));
    hold on;
    plot(x, f(x), 'DisplayName', 'Oryginalna funkcja');
    hold off;
    legend; 
end

% efekt Rungego i wezly Czebyszewa
czebyszew_figure = figure('Name', 'Efekt Rungego i wezly Czebyszewa', 'NumberTitle', 'off');
figure(czebyszew_figure);

subplot(2, 1, 1);
title("Efekt Rungego");
hold on;
plot(x, f(x), 'DisplayName', 'Oryginalna funkcja');

xn = linspace(-1, 1, 5);
yn = f(xn);

runge_xn = linspace(-1, 1, 15);
runge_yn = f(runge_xn);

fn_newton = [];
runge_newton = [];
for i = 1 : 100
    fn_newton = [fn_newton newton_int(xn, yn, x(i))];
    runge_newton = [runge_newton newton_int(runge_xn, runge_yn, x(i))];
end

plot(x, fn_newton, plots_colors(1), 'DisplayName', sprintf('Interpolacja Newtona n = %d', 5))
plot(x, runge_newton, plots_colors(2), 'DisplayName', sprintf('Interpolacja Newtona n = %d', 15));
legend;
hold off;

subplot(2, 1, 2);
title("Wezly Czebyszewa");
hold on;
plot(x, f(x), 'DisplayName', 'Oryginalna funkcja');

xn = czebyszew(-1, 1, 15);
yn = f(xn);

fn_czebyszew = [];
for i = 1 : 100
    fn_czebyszew = [fn_czebyszew newton_int(xn, yn, x(i))];
end

plot(x, fn_czebyszew, plots_colors(1), 'DisplayName', sprintf('Interpolacja Newtona n = %d', 15))
legend;
hold off;

% bledy
absolute_errors_figure = uifigure('Name', 'Bledy bezwzgledne', 'Position', [500 500 700 350]);
figure(absolute_errors_figure);
absolute_errors_table = array2table(absolute_errors, "VariableNames", ["Algorytm", "Stopnień n", "k", "ΔFn(x)"]);
uitable(absolute_errors_figure, "Data", absolute_errors_table, "Position", [20 20 680 320]);
display(absolute_errors_table);

relative_errors_figure = uifigure('Name', 'Bledy wzgledne', 'Position', [500 500 700 350]);
figure(relative_errors_figure);
relative_errors_table = array2table(relative_errors, "VariableNames", ["Algorytm", "Stopnień n", "k", "δFn(x)"]);
uitable(relative_errors_figure, "Data", relative_errors_table, "Position", [20 20 680 320]);
display(relative_errors_table);
