function [results] = newton_raphson(f, a, b, e, dx, diff_method)
    results = [];

    fa = f(a);
    fb = f(b);

    if fa * fb > 0
        disp("There is no result in given interval");
        return;
    end

    x = a;
    fx = fa;
    while abs(fx) > e
        switch diff_method
            case "backward"
                prev_x = x - dx;
                dfx = (f(x) - f(prev_x)) / dx;
            case "forward"
                next_x = x + dx;
                dfx = (f(next_x) - f(x)) / dx;
            case "central"
                prev_x = x - dx;
                next_x = x + dx;
                dfx = (f(next_x) - f(prev_x)) / dx;
            otherwise
                disp("Wrong diff method");
                return;
        end

        x = x - (fx / dfx);
        fx = f(x);

        results = [results x];
    end
end

