function [c, ceq] = simple_constraint(x)
c = [];
ceq = [mod(x(1),5); mod(x(2),5)];