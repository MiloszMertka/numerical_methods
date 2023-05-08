function result = kw_38(f, a, b)
    q = (b - a) / 3;
    c = a + q;
    d = a + 2 * q;
    fa = f(a);
    fb = f(b);
    fc = f(c);
    fd = f(d);
    result = (fa + fb + 3 * fc + 3 * fd) / 8 * abs(b - a);
end
