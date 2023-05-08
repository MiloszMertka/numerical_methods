function result = kw_prost(f, a, b)
    fa = f(a);
    result = fa * abs(b - a);
end
