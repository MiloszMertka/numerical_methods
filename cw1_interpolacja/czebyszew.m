function x = czebyszew(a, b, n)
    x = [];
    
    for i = 1 : n
        x = [x (0.5 * (a + b) + 0.5 * (b - a) * cos(((2 * i - 1) / (2 * n)) * pi))];
    end
end
