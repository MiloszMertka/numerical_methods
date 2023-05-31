function [results] = bisection(f, a, b, e)
    results = [];

    fa = f(a);
    fb = f(b);

    if fa * fb > 0
        disp("There is no result in given interval");
        return;
    end

    fx = realmax;
    while abs(fx) > e
        x = (a + b) / 2;
        fx = f(x);

        results = [results x];

        if fx * fa < 0
            b = x;
        else
            a = x;
            fa = fx;
        end
    end
end
