function obs = observe(x,L,W,flag_noise,R)
x0 = x(1);
y0 = x(2);
theta0 = normalize_theta(x(3));

% theta0

%Special cases
if theta0 == 0
    obs = [L-x0;y0;theta0];
elseif theta0 == -pi
    obs = [x0;W-y0;theta0];
elseif theta0 == pi/2
    obs = [W-y0;L-x0;theta0];
elseif theta0 == -pi/2
    obs = [y0;x0;theta0];
    
else    %Four Qurduants
    obs = zeros(3,1);
    if theta0>0 && theta0 <pi/2
        pf = find_nearst(x,L,W,[L,W]);
        pr = find_nearst([x0;y0;normalize_theta(theta0-pi/2)],L,W,[L,0]);
    elseif theta0>-pi/2 && theta0 <0
        pf = find_nearst(x,L,W,[L,0]);
        pr = find_nearst([x0;y0;normalize_theta(theta0-pi/2)],L,W,[0,0]);
        
    elseif theta0>-pi && theta0 <-pi/2
        pf = find_nearst(x,L,W,[0,0]);
        pr = find_nearst([x0;y0;normalize_theta(theta0-pi/2)],L,W,[0,W]);
        
    elseif theta0>pi/2 && theta0 <pi
        pf = find_nearst(x,L,W,[0,W]);
        pr = find_nearst([x0;y0;normalize_theta(theta0-pi/2)],L,W,[L,W]);
    end
    
    obs(1) = sqrt((pf(1) - x0)^2 + (pf(2) - y0)^2);
    obs(2) = sqrt((pr(1) - x0)^2 + (pr(2) - y0)^2);
    obs(3) = theta0;
    
end
if flag_noise == 1
    obs = obs + sqrt(R) * normrnd(0,1,3,1);
end
end


function y = find_nearst(x,L,W,edges)
%edges: Horizaontal and Vertical edge boundaries
x0 = x(1);
y0 = x(2);
theta0 = x(3);

x1 = x0 + (edges(2) - y0)/tan(theta0);
y1 = y0 + (edges(1) - x0) * tan(theta0);

% [x0,y0]
% [x1,y1]
% theta0/pi *180

if y1 >= 0 && y1 <= W %On the vertical edge
    y = [edges(1);y1];
else %On the horizontal edge
    y = [x1;edges(2)];
end
end

function xnew = normalize_theta(x)
xnew = mod(x,2*pi);
if xnew > pi
    xnew = xnew - 2*pi;
end
end

   