function [invA] = inverse(A)
    n = size(A, 1);
    b = eye(n);
    invA = solve_lu(A, b);
end

