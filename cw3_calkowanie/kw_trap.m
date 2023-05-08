function result = kw_trap(f, a, b)
    fa = f(a);
    fb = f(b);
    result = ((fa + fb) / 2) * abs(b - a);
end
