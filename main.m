clc
clear all
close all

%% Setup
L = 750;W = 500;
r = 20; d = 85;
dt = 0.1;

omega_max = 2*pi*130/60;
sigma_omega = 0.05*omega_max;
sigma_range = 1200 * 0.03;
sigma_imu = 0.1/180*2*pi;

M = [sigma_omega^2,0;0,sigma_omega];
R = diag([sigma_range^2,sigma_range^2,sigma_imu^2]);

%% Simulate
x = [100;100;pi/4];
x_bar = x;
%x_bar = [10;10;pi/3];

u0 = [2;5];
u = u0 + sqrt(M) * normrnd(0,1,2,1);

P = eye(3);
 
NStep = 30;
esti_traj = zeros(3,NStep);
true_traj = zeros(3,NStep);
for i = 1:NStep
    esti_traj(:,i) = x_bar;
    true_traj(:,i) = x;
    

    u = u0 + sqrt(M) * normrnd(0,1,2,1);
    x = move(x,u,r,d,dt);
%     x_bar
    [x_bar,P] = ekf(x_bar,x,u0,r,d,dt,P,M,R,L,W);
end

figure;
plot(esti_traj(1,:),esti_traj(2,:),'b')
hold on
plot(true_traj(1,:),true_traj(2,:),'r')
grid on
xlabel('X')
ylabel('y')
legend('Estimated','Ground Truth')