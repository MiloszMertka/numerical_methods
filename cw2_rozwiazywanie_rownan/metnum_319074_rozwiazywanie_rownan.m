A = [10 -1 2 0; -1 11 -1 3; 2 -1 10 -1; 0 3 -1 8];
b = [6; 25; -11; 15];

disp("Macierz stanu:");
disp(A);
disp("Macierz wyrazów wolnych:");
disp(b);

% metody skończone
x = gauss(A, b);
disp("Rozwiązania dla metody Gaussa:");
disp(x);

[L, U, P] = gauss_lu(A);
disp("Macierz dolna trójkątna:");
disp(L);
disp("Macierz górna trójkątna:");
disp(U);
disp("Macierz permutacji:");
disp(P);

x = solve_lu(A, b);
disp("Rozwiązania dla metody dekompozycji LU:");
disp(x);

d = determinant(A);
disp("Wyznacznik macierzy stanu:");
disp(d);

invA = inverse(A);
disp("Macierz odwrotna do macierzy stanu:");
disp(invA);

% metody iteracyjne
e = 10^-4;
w = 0.3;

[x, rho, k] = jacobi(A, b, e);
disp("Rozwiązania dla metody Jacobiego:");
disp(x);
disp("Promień spektralny");
disp(rho);
disp("Liczba iteracji:");
disp(k);

[x, rho, k] = gauss_seidl(A, b, e);
disp("Rozwiązania dla metody Gaussa-Seidla:");
disp(x);
disp("Promień spektralny");
disp(rho);
disp("Liczba iteracji:");
disp(k);

[x, rho, k] = sor(A, b, e, w);
disp("Rozwiązania dla metody SOR:");
disp(x);
disp("Promień spektralny");
disp(rho);
disp("Liczba iteracji:");
disp(k);

results = [];

% mac_1
[A, b] = mac_1;
[~, rho, k] = jacobi(A, b, e);
results = [results; ["mac_1", "jacobi", k, rho, "-"]];
[~, rho, k] = gauss_seidl(A, b, e);
results = [results; ["mac_1", "gauss-seidl", k, rho, "-"]];
for w = 0.2 : 0.2 : 1.8
    [~, rho, k] = sor(A, b, e, w);
    results = [results; ["mac_1", "sor", k, rho, w]];
end

% mac_2
[A, b] = mac_2;
[~, rho, k] = jacobi(A, b, e);
results = [results; ["mac_2", "jacobi", k, rho, "-"]];
[~, rho, k] = gauss_seidl(A, b, e);
results = [results; ["mac_2", "gauss-seidl", k, rho, "-"]];
for w = 0.2 : 0.2 : 1.8
    [~, rho, k] = sor(A, b, e, w);
    results = [results; ["mac_2", "sor", k, rho, w]];
end

% mac_3
basis = [20, 1, 0.1];
for i = 1 : length(basis)
    [A, b] = mac_3(basis(i));
    [~, rho, k] = jacobi(A, b, e);
    label = strcat("mac_3 (basis = ", num2str(basis(i)), ")");
    if k ~= 0
        results = [results; [label, "jacobi", k, rho, "-"]];
    end
    [~, rho, k] = gauss_seidl(A, b, e);
    if k ~= 0
        results = [results; [label, "gauss-seidl", k, rho, "-"]];
    end
    for w = 0.2 : 0.2 : 1.8
        [~, rho, k] = sor(A, b, e, w);
        if k ~= 0
            results = [results; [label, "sor", k, rho, w]];
        end
    end
end

% mac_5
% mac_5 = matfile("mac_5.mat");
% A = mac_5.A;
% b = mac_5.b;
% [~, rho, k] = jacobi(A, b, e);
% if k ~= 0
%     results = [results; ["mac_5", "jacobi", k, rho, "-"]];
% end
% [~, rho, k] = gauss_seidl(A, b, e);
% if k ~= 0
%     results = [results; ["mac_5", "gauss-seidl", k, rho, "-"]];
% end
% for w = 0.2 : 0.2 : 1.8
%     [~, rho, k] = sor(A, b, e, w);
%     if k ~= 0
%         results = [results; ["mac_5", "sor", k, rho, w]];
%     end
% end

table = array2table(results, "VariableNames", ["Macierz", "Metoda", "Liczb iteracji", "Promień spektralny", "Omega"]);
disp(table);
