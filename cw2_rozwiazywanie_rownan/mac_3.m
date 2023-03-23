function [A,b] = mac_3(basis)
% Prosze wykonac analize dla trzech wartosci wspolczynnika basis:
% basis = 20;
% basis = 1;
% basis = 0.1;


A = zeros(6);
b = zeros(6,1);
for i = 1:6
    for j = 1:6
        A(i,j) = basis / (i+j-1);
    end
    
    b(i) = basis / i;
end

