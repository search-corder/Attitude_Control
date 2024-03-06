
[t, nonOLC, u_nonOLC] = rk(OLC0, h, time);

function [t, sol, u] = rk(sol0, h, time)

n = time/h+1;
t = 0: h: time;
N = length(sol0);
sol = zeros(N, n);
sol(:, 1) = sol0;
u = zeros(3, n);

for i=1:n-1
    [k1, u(:, i+1)]=diffeq(t(i), sol(:, i));
    [k2, ~]=diffeq(t(i)+h/2, sol(:, i)+h*k1/2);
    [k3, ~]=diffeq(t(i)+h/2, sol(:, i)+h*(k1+k2)/4);
    [k4, ~]=diffeq(t(i)+h/2, sol(:, i)+h*(k1+k2+k3)/6);
    [k5, ~]=diffeq(t(i)+h, sol(:, i)+h*(k1+k2+k3+k4)/8);
    sol(:, i+1)=sol(:, i)+h*(k1+k2+k3+k4+k5)/5;
end

end

function [dwdqdt, u] = diffeq(t, nonOLC)

w = [nonOLC(1); nonOLC(2); nonOLC(3)];
q0 = nonOLC(4);
q = [nonOLC(5); nonOLC(6); nonOLC(7)];

J0 = [20, 2, 0.9; 2, 18, 0.5; 0.9, 0.5, 15];
delJ = diag([(3+sin(0.5*t))*exp(-0.1*t)+1, (4+cos(0.5*t))*exp(-0.1*t)+2, (5+sin(0.5*t))*exp(-0.1*t)-1]);
J = J0 + delJ;

u = control(t, w, q0, q, J);

if t<=20
    d = [0; 0; 0];
else
    d = [-3*cos(0.5*t)-6*sin(0.15*t)+3; 10; 0]*0.01;
end

dw = inv(J)*(cross(w, (J*w))+u+d);
dq0 = -0.5*q'*w;
dq = 0.5*q0*w + 0.5*cross(q, w);

dwdqdt = zeros(7, 1);
dwdqdt(1) = dw(1);
dwdqdt(2) = dw(2);
dwdqdt(3) = dw(3);
dwdqdt(4) = dq0;
dwdqdt(5) = dq(1);
dwdqdt(6) = dq(2);
dwdqdt(7) = dq(3);

end

function u = control(t, w, q0, q, J)

k1 = 0.8;
k2 = 2;
alpha = 1;
ksai = 1/(1+t.^2);
roinf = 0.2;

s = w + q;
P = cross((J*w), w)+0.5*J*(q0*w-cross(w, q));
ro1 = norm(s(1)) + ksai + roinf;
ro2 = norm(s(2)) + ksai + roinf;
ro3 = norm(s(3)) + ksai + roinf;
epsi1 = s(1)/ro1;
epsi2 = s(2)/ro2;
epsi3 = s(3)/ro3;
T1 = alpha*log((1+epsi1)/(1-epsi1));
T2 = alpha*log((1+epsi2)/(1-epsi2));
T3 = alpha*log((1+epsi3)/(1-epsi3));
T = [T1; T2; T3];
u = sat(-k2*(T-((1-k1)/k2)*P), 1);

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