function yv = newton_int(xn, yn, x)
    sum = 0;
    N = length(xn);

    A = zeros(N, N + 1);
    A(:, 1) = xn;
    A(:, 2) = yn;

    for column = 3 : N + 1
        for row = 1 : N - 1
            if (row + column - 2 > N)
                break
            end

            nom = A(row + 1, column - 1) - A(row, column - 1);
            denom = A(row + column - 2, 1) - A(row, 1);
            A(row, column) = nom / denom;
        end
    end

    for i = 2 : N + 1
        value = A(1, i);

        for j = i - 2 : -1 : 1
            value = value * (x - xn(j));
        end

        sum = sum + value;
    end

    yv = sum;
end
