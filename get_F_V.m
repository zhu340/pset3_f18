function [F_t,V_t] = get_F_V(x,u,r,d,dt)
syms x_t y_t theta_t omega_r omega_l

delta_theta = (omega_r - omega_l)*r/d * dt;
delta_s = (omega_r + omega_l)*r/2 * dt;

x1 = x_t + delta_s * cos(theta_t + delta_theta/2);
y1 = y_t + delta_s * sin(theta_t + delta_theta/2);
theta1 = theta_t + delta_theta;

f = [x1;y1;theta1];

V = jacobian(f,[omega_r;omega_l]);
F = jacobian(f,[x_t;y_t;theta_t]);
F_t = vpa(subs(F,[x_t,y_t,theta_t,omega_r omega_l],[x',u']));
V_t = vpa(subs(V,[theta_t,omega_r omega_l],[x(3),u']));
end
