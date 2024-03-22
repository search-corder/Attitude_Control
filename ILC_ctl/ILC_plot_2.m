w = ilc(1:3, :);
Q = ilc(4:7, :);

figure
plot(t, w)
xlabel('t')
ylabel('\omega')
legend('\omega_x', '\omega_y', '\omega_z')
figure
plot(t, Q)
xlabel('t')
ylabel('Q')
legend('\epsilon', 'q_1', 'q_2', 'q_3')
figure
subplot(3, 1, 1)
plot(t, u(1, :))
ylim([-0.2, 0.2])
xlabel('t')
ylabel('u_x')
subplot(3, 1, 2)
plot(t, u(2, :))
ylim([-0.2, 0.2])
xlabel('t')
ylabel('u_y')
subplot(3, 1, 3)
plot(t, u(3, :))
ylim([-0.2, 0.2])
xlabel('t')
ylabel('u_z')
figure
plot(k, we_max)
xlabel('k')
ylabel('\omega_e max')
figure
plot(k, alpha_max)
xlabel('k')
ylabel('max|\alpha_k(t)|')