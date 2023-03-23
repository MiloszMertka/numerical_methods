function [x, rho, k] = sor(A, b, e, w)
    n = size(A, 1);
    x = ones(n, 1);
    k = 0;
    rho = NaN;

    if w <= 0 || w >= 2
        disp("Parametr omega poza dozwolonym zakresem.")
        return;
    end

    if n > 1
        L = tril(A, -1);
        U = triu(A, 1);
    else
        L = A;
        U = A;
    end
    
    D = diag(diag(A));

    rho_jacobi = max(abs(eig(D \ (L + U))));

    if rho_jacobi >= 1
        disp("Promień spektralny macierzy iteracji Jacobiego >= 1. Nie można zastosować metody iteracyjnej.");
        return;
    end

    wopt = 1 + (rho_jacobi / (1 + sqrt(1 - rho_jacobi^2)))^2;

    if w <= wopt
        rho = 0.25 * (w * rho_jacobi + sqrt(w^2 * rho_jacobi^2 - 4 * (w - 1)))^2;
    else
        rho = w - 1;
    end

    while norm(A * x - b) >= e
        xn = (D + w * L) \ (-(w * U + (w - 1) * D) * x + w * b);
        x = xn;
        k = k + 1;
    end
end
