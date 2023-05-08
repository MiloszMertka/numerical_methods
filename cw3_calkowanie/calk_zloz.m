function [sum, steps] = calk_zloz(f, a, b, h, d)
    sum = 0;
    steps = [0];
    for i = a + h : h : b
        xa = i - h;
        xb = i;

        if d == 1
            In = kw_prost(f, xa, xb);
        elseif d == 2
            In = kw_trap(f, xa, xb);
        elseif d == 3
            In = kw_simpson(f, xa, xb);
        elseif d == 4
            In = kw_38(f, xa, xb);
        else
            disp("Argument d nieprawidlowy");
            return;
        end

        sum = sum + In;
        steps = [steps; sum];
    end
end
