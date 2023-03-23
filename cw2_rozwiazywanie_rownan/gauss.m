function [x] = gauss(A, b)
    n = size(A, 1);
    x = zeros(n, 1);

    for i = 1 : n
        [~, max_index] = max(abs(A(i:n, i)));
        max_index = max_index + i - 1;

        tempA = A(max_index, :);
        tempb = b(max_index);
        A(max_index, :) = A(i, :);
        b(max_index) = b(i);
        A(i, :) = tempA;
        b(i) = tempb;

        for j = i + 1 : n
            l = A(j, i) / A(i, i);
            A(j, :) = A(j, :) - l * A(i, :);
            b(j) = b(j) - l * b(i);
        end
    end

    for i = n : -1 : 1
        sum = 0;

        for j = n : -1 : i + 1
            sum = sum + A(i, j) * x(j);
        end

        x(i) = (b(i) - sum) / A(i, i);
    end
end

