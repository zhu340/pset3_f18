function x_nxt = move(x,u,r,d,dt)
%xt
x0 = x(1);
y0 = x(2);
theta0 = x(3);
%u
omega_r = u(1);
omega_l = u(2);

delta_theta = (omega_r - omega_l)*r/d * dt;
delta_s = (omega_r + omega_l)*r/2 * dt;

%xt+1
x1 = x0 + delta_s * cos(theta0 + delta_theta/2);
y1 = y0 + delta_s * sin(theta0 + delta_theta/2);
theta1 = theta0 + delta_theta;

x_nxt = [x1;y1;theta1];
end

