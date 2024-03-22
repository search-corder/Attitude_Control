
[t, ilc, u, wen, alpha, theta] = r_k(ILC0, h, T, theta_d, dJk);

function [t, sol, u, wen, alpha, theta] = r_k(sol0, h, T, theta_d, dJk)

n = T/h;
t = 0: h: T;
te = 0: h/2: T;
N = length(sol0);
sol = zeros(N, n);
sol(:, 1) = sol0;
wpi = 0.0011;
wd = [pi/8*pi/400*sin(pi/400*te); -wpi*cos(-pi/8*cos(pi/400*te)+pi/8); wpi*sin(-pi/8*cos(pi/400*te)+pi/8)];
wdd = zeros(3, length(te));
for i = 1: length(te)-1
    wdd(:, i) = (wd(:, i+1)-wd(:, i))/(h/2);
end
epd0 = 0.66;
qd0 = [0.34; -0.62; 0.25];
epd = zeros(1, length(te));
epd(1) = epd0;
qd = zeros(3, length(te));
qd(:, 1) = qd0;
[eulerx, eulery, eulerz] = quat2angle([epd0, qd0']);
euler = zeros(3, length(te));
euler(:, 1) = [eulerx; eulery; eulerz];
for i = 2 : length(te)
    euler(:, i) = euler(:, i-1) + wd(:, i-1)*h/2;
    Q = angle2quat(euler(1, i), euler(2, i), euler(3, i));
    epd(i) = Q(1);
    qd(:, i) = [Q(2); Q(3); Q(4)];
    [epd(i), qd(:, i)] = nml(epd(i), qd(:, i));
end
Qd = [epd; qd];
u = zeros(3, length(t));
wen = zeros(1, length(t));
alpha = zeros(1, length(t));
theta = zeros(1, length(t));

for i=1:n
    [k1, u(:, i), wen(i), alpha(i), theta(i)]=diffeq(t(i), sol(:, i), theta_d(i), Qd(:, 2*i-1), wd(:, 2*i-1), dJk, wdd(:, 2*i-1));
    [k2, ~]=diffeq(t(i)+h/2, sol(:, i)+h*k1/2, 0.5*(theta_d(i)+theta_d(i+1)), Qd(:, 2*i), wd(:, 2*i), dJk, wdd(:, 2*i));
    [k3, ~]=diffeq(t(i)+h/2, sol(:, i)+h*(k1+k2)/4, 0.5*(theta_d(i)+theta_d(i+1)), Qd(:, 2*i), wd(:, 2*i), dJk, wdd(:, 2*i));
    [k4, ~]=diffeq(t(i)+h/2, sol(:, i)+h*(k1+k2+k3)/6, 0.5*(theta_d(i)+theta_d(i+1)), Qd(:, 2*i), wd(:, 2*i), dJk, wdd(:, 2*i));
    [k5, ~]=diffeq(t(i)+h, sol(:, i)+h*(k1+k2+k3+k4)/8, theta_d(i+1), Qd(:, 2*i+1), wd(:, 2*i+1), dJk, wdd(:, 2*i+1));
    sol(:, i+1)=sol(:, i)+h*(k1+k2+k3+k4+k5)/5;
end

% for i=1:n-1
%     [k1, we(:, i), alpha(i), theta(i)]=diffeq(t(i), sol(:, i), theta_d(i), Qd(:, 2*i-1), wd(:, 2*i-1));
%     [k2, ~]=diffeq(t(i)+h/2, sol(:, i)+h*k1/2, 0.5*(theta_d(i)+theta_d(i+1)), Qd(:, 2*i), wd(:, 2*i));
%     [k3, ~]=diffeq(t(i)+h/2, sol(:, i)+h*k2/2, 0.5*(theta_d(i)+theta_d(i+1)), Qd(:, 2*i), wd(:, 2*i));
%     [k4, ~]=diffeq(t(i)+h, sol(:, i)+h*k3, theta_d(i+1), Qd(:, 2*i+1), wd(:, 2*i+1));
%     sol(:, i+1)=sol(:, i)+h*(k1+k2+k3+k4)/6;
% end

end

function [dwdqdt, u, wen, alpha, theta] = diffeq(t, ILC, theta_d, Qd, wd, dJk, wdd)

w = [ILC(1); ILC(2); ILC(3)];
ep = ILC(4);
q = [ILC(5); ILC(6); ILC(7)];

[ep, q] = nml(ep, q);

J = [20, 2, 1; 2, 15, 3; 1, 3, 15];

Jk = J + dJk;
%rng(0)
%d = [0.1*sin(pi/20*t+100*(-1+2*rand)); 0.05*sin(pi/25*t+100*(-1+2*rand)); 0.08*sin(pi/35*t+100*(-1+2*rand))];
d = [0.1*sin(pi/20*t+10); 0.05*sin(pi/25*t+20); 0.05*sin(pi/50*t+30)];

[we, epe, qe] = target(w, ep, q, Qd, wd);

wen = norm(we);

[u, theta] = control(we, epe, qe, theta_d, d, wd, wdd);

dw = inv(Jk)*(-crossmatrix(w)*Jk*w+u+d);
dep = -0.5*q'*w;
dq = 0.5*(crossmatrix(q)+ep*eye(3))*w;

alpha = 2*acos((1-qe'*qe)^0.5);

dwdqdt = zeros(7, 1);
dwdqdt(1) = dw(1);
dwdqdt(2) = dw(2);
dwdqdt(3) = dw(3);
dwdqdt(4) = dep;
dwdqdt(5) = dq(1);
dwdqdt(6) = dq(2);
dwdqdt(7) = dq(3);

end

function [we, epe, qe] = target(w, ep, q, Qd, wd)

epd = Qd(1);
qd = [Qd(2); Qd(3); Qd(4)];
epe = epd*ep + q'*qd;
qe = epd*q - ep*qd + crossmatrix(q)*qd;
[epe, qe] = nml(epe, qe);
R = (epe*epe-qe'*qe)*eye(3) + 2*(qe*qe') - 2*epe*crossmatrix(qe);
we = w - R*wd;

end

function [u, theta] = control(we, epe, qe, theta_d, d, wd, wdd)

kp = 2;
kd = 5;
gam1 = 10;
gam2 = 0.01;
sig = 0.0001;
beta_J = norm([20.5, 2.5, 1.5; 2.5, 15.5, 3.5; 1.5, 3.5, 15.5]);
beta_d = norm(d);
bou = beta_J*((norm(wd))^2+norm(wdd))+beta_d;
theta = (1-gam2)*theta_d+gam1*we'*tanh(we/sig);
if theta < bou
    theta = bou;
end
u = -kp*epe*qe-kd*we-theta*tanh(we/sig);
u = sat(u, 0.2);
u = deadzone(u, 0.0001);

end

function ax = crossmatrix(a)

ax = [0, -a(3), a(2); a(3), 0, -a(1); -a(2), a(1), 0];

end

function y = sat(x, s)

y = zeros(3, 1);
for i = 1: 3
    if x(i) < -s
        y(i) = -s;
    elseif x(i) > s
        y(i) = s;
    else
        y(i) = x(i);
    end
end

end

function [ep_n, q_n] = nml(ep, q)

Q = [ep, q'];
Q_n = Q ./ norm(Q);
ep_n = Q_n(1);
q_n = [Q_n(2); Q_n(3); Q_n(4)];

end

function T = deadzone(u, s)

T = zeros(3, 1);
for i = 1: 3
    if u(i)<s && u(i)>-s
    T(i) = 0;
else
    T(i) = u(i);
    end
end

end