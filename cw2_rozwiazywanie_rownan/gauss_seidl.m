function [x, rho, k] = gauss_seidl(A, b, e)
    n = size(A, 1);
    x = ones(n, 1);
    k = 0;
    rho = NaN;

    if n > 1
        L = tril(A, -1);
        U = triu(A, 1);
    else
        L = A;
        U = A;
    end
    
    D = diag(diag(A));

    rho = max(abs(eig(eye(n) - D \ A)))^2;

    if rho >= 1
        disp("Promień spektralny >= 1. Nie można zastosować metody iteracyjnej.");
        return;
    end

    while norm(A * x - b) >= e
        xn = (D + L) \ (-U * x + b);
        x = xn;
        k = k + 1;
    end
end
