clear all;
syms M m l theta dtheta d2theta x dx d2x g
x_p = x + l*sin(theta);
y_p = l*cos(theta);
dx_p = dx+l*cos(theta)*dtheta;
dy_p = l*sin(theta)*dtheta;

T = 1/2*(M*dx^2+m*(dx_p^2+dy_p^2));
V = -m*g*y_p;
L = T - V;
Eq = Lagrange(L, [x dx d2x theta dtheta d2theta]);
pretty(Eq)
