function result = kw_simpson(f, a, b)
    c = (a + b) / 2;
    fa = f(a);
    fb = f(b);
    fc = f(c);
    result = ((fa + fb + 4 * fc) / (2 * 3)) * abs(b - a);
end
