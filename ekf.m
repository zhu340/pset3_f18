function [x_nxt,p_nxt] = ekf(x_bar,x,u,r,d,dt,P,M,R,L,W)
%Input:
%x_bar: current extimate
%x:ground truth of current state
%u: input
%r,d,dt,L,W:parameters
%P,M,R: covariance matrices


x_bar = move(x,u,r,d,dt);

[F,V] = get_F_V(x_bar,u,r,d,dt);
F = double(F);
V = double(V);
%x_bar = F * x_bar;

P=F*P*F'+ V*M*V'; 

%v_t = sqrt(R) * normrnd(0,1,3,1);

[y,H] = get_H(x,L,W,0,R);
H = double(H);
K = P * H' * inv(H * P * H' + R);

%y = observe(x,L,W,0,R);%x

x_nxt = x_bar + K*(y-H*x_bar);
p_nxt = (eye(3) - K*H) * P;


end