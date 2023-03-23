function [d] = determinant(A)
    [L, U, P] = gauss_lu(A);
    invP = inv(P);
    d = det(invP) * det(L) * det(U);
end
