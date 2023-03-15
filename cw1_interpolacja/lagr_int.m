function yv = lagr_int(xn, yn, x)
    nom = 1;
    denom = 1;
    sum = 0;
    N = length(xn);
    for i = 1 : N
        for k = 1 : N
            if(i ~= k)
                nom = nom * (x - xn(k));
                denom = denom * (xn(i) - xn(k));
            end
        end
        sum = sum + yn(i) * nom / denom;
        nom = 1;
        denom = 1;
    end
    yv = sum;
end
