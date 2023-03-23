function [L, U, P] = gauss_lu(A)
    n = size(A, 1);
    L = eye(n);
    P = eye(n);

    for i = 1 : n
        [~, max_index] = max(abs(A(i:n, i)));
        max_index = max_index + i - 1;

        tempA = A(max_index, :);
        tempP = P(max_index, :);
        A(max_index, :) = A(i, :);
        P(max_index, :) = P(i, :);
        A(i, :) = tempA;
        P(i, :) = tempP;

        for j = i + 1 : n
            l = A(j, i) / A(i, i);
            A(j, :) = A(j, :) - l * A(i, :);
            L(j, i) = l;
        end
    end

    U = A;
end
