delJ = [(3+sin(0.5*t)).*exp(-0.1*t)+1; (4+cos(0.5*t)).*exp(-0.1*t)+2; (5+sin(0.5*t)).*exp(-0.1*t)-1];
d = zeros(3, length(t));
for i = 1: length(t)
    if t(i) < 20
        d(:, i) = 0;
    else
        d(1, i) = 0.01*(-3*cos(0.5*t(i))-6*sin(0.15*t(i))+3);
        d(2, i) = 0.01*10;
        d(3, i) = 0;
    end
end

w_OLC = OLC(1:3, :);
w_nonOLC = nonOLC(1:3, :);

q0_OLC = OLC(4, :);
q1_OLC = OLC(5, :);
q2_OLC = OLC(6, :);
q3_OLC = OLC(7, :);
q0_nonOLC = nonOLC(4, :);
q1_nonOLC = nonOLC(5, :);
q2_nonOLC = nonOLC(6, :);
q3_nonOLC = nonOLC(7, :);
phi_OLC = zeros(1, length(t));
theta_OLC = zeros(1, length(t));
psi_OLC = zeros(1, length(t));
phi_nonOLC = zeros(1, length(t));
theta_nonOLC = zeros(1, length(t));
psi_nonOLC = zeros(1, length(t));
for i = 1:length(t)
    [phi_OLC(i), theta_OLC(i), psi_OLC(i)] = quat2angle([q0_OLC(i), q1_OLC(i), q2_OLC(i), q3_OLC(i)]);
    [phi_nonOLC(i), theta_nonOLC(i), psi_nonOLC(i)] = quat2angle([q0_nonOLC(i), q1_nonOLC(i), q2_nonOLC(i), q3_nonOLC(i)]);
end

P_OLC = zeros(3, length(t));
P_nonOLC = zeros(3, length(t));
for i = 2: length(t)
    P_OLC(:, i) = P_OLC(:, i-1) + abs(u_OLC(:, i));
    P_nonOLC(:, i) = P_nonOLC(:, i-1) + abs(u_nonOLC(:, i));
end
E = P_OLC./P_nonOLC;