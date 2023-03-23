function [x] = solve_lu(A, b)
    [L, U, P] = gauss_lu(A);
    Y = L \ (P * b);
    x = U \ Y;
end
