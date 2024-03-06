clear;
clc;

d2r = pi/180;
Ww0 = [0.1 0.1 0.1]'*d2r;
%HB0 = [IB*Ww0]';
fei0 = [0, 42.7, 5.6]'*d2r;
fei1 = [10, 10, 30]'*d2r;

Q00 = cos(fei0(1)/2)*cos(fei0(2)/2)*cos(fei0(3)/2) + sin(fei0(1)/2)*sin(fei0(2)/2)*sin(fei0(3)/2);
Q1 = sin(fei0(1)/2)*cos(fei0(2)/2)*cos(fei0(3)/2) - cos(fei0(1)/2)*sin(fei0(2)/2)*sin(fei0(3)/2);
Q2 = cos(fei0(1)/2)*sin(fei0(2)/2)*cos(fei0(3)/2) + sin(fei0(1)/2)*cos(fei0(2)/2)*sin(fei0(3)/2);
Q3 = -sin(fei0(1)/2)*sin(fei0(2)/2)*cos(fei0(3)/2) + cos(fei0(1)/2)*cos(fei0(2)/2)*sin(fei0(3)/2);
Q0 = [Q1 Q2 Q3];

sol0 = [Ww0', Q00, Q0];

[t, sol] = ode45(@diffeq, [0, 10], sol0);

wib = (sol(:, 1: 3))';
q0 = (sol(:, 4))';
q1 = (sol(:, 5))';
q2 = (sol(:, 6))';
q3 = (sol(:, 7))';
q = [q1; q2; q3];
wob = rotate(wib, q0, q);
figure
plot(t', wob)
xlabel('t')
ylabel('{\omega}^o_b')
legend('{\omega}^o_bx', '{\omega}^o_by', '{\omega}^o_bz')
phi = atan(2.*(q2.*q3 + q0.*q1)./(q0.*q0 - q1.*q1 - q2.*q2 + q3.*q3));
theta = asin(-2.*(q1.*q3 - q0.*q2));
psi = atan(2.*(q1.*q2 + q0.*q3)./(q0.*q0 + q1.*q1 - q2.*q2 - q3.*q3));
Euler = [phi; theta; psi];
dEuler = Euler - fei1;
figure
plot(t', dEuler)
xlabel('t')
ylabel('dEuler')
legend('\phi-\phi_t', '\theta-\theta_t', '\psi-\psi_t')

function dwdqdt = diffeq(t, sol)

d2r = pi/180;

IB = [1.25, 0.0, 0.0
      0.0, 9.65, 0.0
      0.0, 0.0, 9.65];

fei1 = [10, 10, 30]'*d2r;

qt0 = cos(fei1(1)/2)*cos(fei1(2)/2)*cos(fei1(3)/2) + sin(fei1(1)/2)*sin(fei1(2)/2)*sin(fei1(3)/2);
qt1 = sin(fei1(1)/2)*cos(fei1(2)/2)*cos(fei1(3)/2) - cos(fei1(1)/2)*sin(fei1(2)/2)*sin(fei1(3)/2);
qt2 = cos(fei1(1)/2)*sin(fei1(2)/2)*cos(fei1(3)/2) + sin(fei1(1)/2)*cos(fei1(2)/2)*sin(fei1(3)/2);
qt3 = -sin(fei1(1)/2)*sin(fei1(2)/2)*cos(fei1(3)/2) + cos(fei1(1)/2)*cos(fei1(2)/2)*sin(fei1(3)/2);
%Qt = [qt0 qt1 qt2 qt3];
qt = [qt1 qt2 qt3]';

Wio = [0 -2*pi/5431.184 0]';


wnx = 5;
wny = 5;
wnz = 5;
Kp = [1.25/0.515*wnx^2*0.6, 9.65/3.18*wny^2*0.6, 9.65/1.59*wnz^2*0.6]*2;
Kd = [2*wnx*1.25/0.515*2, 2*wny*9.65/3.18, 2*wnz*9.65/1.59*2]*sqrt(0.6);

wib = [sol(1);sol(2);sol(3)];
q0 = sol(4);
q = [sol(5); sol(6); sol(7)];
Q = [q0; q];

C = q*q' + (q0*eye(3) - q)^2;
wob = wib - C*Wio;
wobm = Gyro(t, wob);
%qe0 = qt0*q0 + qt'*q;
qe = -qt*q0 + qt0*q + cross(-qt, q);
T = -Kp'.*qe - Kd'.*wobm;

dw = inv(IB)*(T - cross(wib, (IB*wib)));
dq0 = -0.5*q'*wob;
dq = 0.5*q0*wob + 0.5*cross(q, wob);

dwdqdt = zeros(7, 1);
dwdqdt(1) = dw(1);
dwdqdt(2) = dw(2);
dwdqdt(3) = dw(3);
dwdqdt(4) = dq0;
dwdqdt(5) = dq(1);
dwdqdt(6) = dq(2);
dwdqdt(7) = dq(3);
end


function wm = Gyro(t, w)

d2r = pi/180;
cong = [1, 1, 1]*0.5/3600*d2r;
Noig = [1, 1, 1]*1/3*5*10^(-5)*d2r;
Gyquan = [1, 1, 1]*1.e-6*d2r;

rng(0);
noise = Noig.*random('Normal', 0, 1, 3, length(t));
wm = Gyquan .* round((w + noise + cong)./Gyquan);

end

function wob = rotate(w, q0, q)

wob = zeros(size(w));
Wio = [0 -2*pi/5431.184 0]';
for i = 1: max(size(w))
    C = q(:, i)*(q(:, i))' + (q0(i)*eye(3) - q(:, i))^2;
    wob(1:3, i) = w(:, i) - C*Wio;
end

end