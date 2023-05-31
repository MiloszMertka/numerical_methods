y = @(x) -0.1*x.^3 + 50 - 0.02*exp(x);
a = -10;
b = 10;
n = 2000;
xn = linspace(a, b, n);

yn = [];
for i = 1 : n
    yn = [yn y(xn(i))];
end

% bisekcja
e = 10^-8;
results = bisection(y, a, b, e);

num_of_iterations = length(results);
found_x = results(num_of_iterations);

disp("Bisection Root found for x = " + found_x);
disp("Bisection Root value = " + y(found_x));
disp("Bisection Number of iterations = " + num_of_iterations);

plot(xn, yn);
xlabel("x");
ylabel("y");
grid on;
title("Bisection method");

hold on;
for i = 1 : num_of_iterations
    xi = results(i);
    yi = y(xi);
    plot(xi, yi, 'o');
end
hold off;

% newton-raphson
e = 10^-7;
dx = 10^-1;
diff_method = "forward";
results = newton_raphson(y, a, b, e, dx, diff_method);

num_of_iterations = length(results);
found_x = results(num_of_iterations);

disp("Newton Raphson Root found for x = " + found_x);
disp("Newton Raphson Root value = " + y(found_x));
disp("Newton Raphson Number of iterations = " + num_of_iterations);

figure;
plot(xn, yn);
xlabel("x");
ylabel("y");
grid on;
title("Newton Raphson method");

hold on;
plot(found_x, y(found_x), 'o');
hold off;

% newton-raphson - porownanie liczby iteracji w zaleznosci od parametrow
dx_labels = ["1e-1" "1e-2" "1e-3" "1e-4" "1e-5"];
e_labels = ["1e-1" "1e-2" "1e-3" "1e-4" "1e-5" "1e-6" "1e-7" "1e-8" "1e-9" "1e-10" "1e-11" "1e-12" "1e-13" "1e-14"];
diff_method = "forward";
for i = 1 : 5
    dx = 10^(-1 * i);
    nums_of_iterations = [];
    for j = 1 : 14
        e = 10^(-1 * j);
        results = newton_raphson(y, a, b, e, dx, diff_method);
        num_of_iterations = length(results);
        nums_of_iterations = [nums_of_iterations num_of_iterations];
    end
    figure;
    bar(categorical(e_labels), nums_of_iterations);
    title("Newton Raphson method - number of iterations for dx = " + dx_labels(i));
    xlabel("Allowable error");
    ylabel("Number of iterations");
    legend("dx=" + dx_labels(i));
    grid on;
end

% newton-raphson - porownanie liczby iteracji w zaleznosci od sposobu
% liczenia pochodnej
e = 10^-7;
dx = 10^-1;

diff_method = "backward";
results = newton_raphson(y, a, b, e, dx, diff_method);
num_of_iterations_backward = length(results);

diff_method = "forward";
results = newton_raphson(y, a, b, e, dx, diff_method);
num_of_iterations_forward = length(results);

diff_method = "central";
results = newton_raphson(y, a, b, e, dx, diff_method);
num_of_iterations_central = length(results);

disp("Newton Raphson Number of iterations for backward diff method = " + num_of_iterations_backward);
disp("Newton Raphson Number of iterations for forward diff method = " + num_of_iterations_forward);
disp("Newton Raphson Number of iterations for central diff method = " + num_of_iterations_central);
