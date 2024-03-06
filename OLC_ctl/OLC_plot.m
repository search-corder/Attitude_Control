figure
subplot(2, 1, 1)
plot(t, delJ(1, :))
hold on
plot(t, delJ(2, :))
plot(t, delJ(3, :))
hold off
grid on
xlim([0, 100])
ylim([-2, 7])
ylabel('Inertia Uncertainty')
legend('\DeltaJ_1','\DeltaJ_2', '\DeltaJ_3', 'Orientation', 'horizontal')
legend('boxoff')
subplot(2, 1, 2)
plot(t, d(1, :))
hold on
plot(t, d(2, :))
plot(t, d(3, :))
hold off
grid on
xlim([0, 100])
ylim([-0.1, 0.2])
ylabel('Distuebance')
legend('d_1','d_2', 'd_3', 'Orientation', 'horizontal')
legend('boxoff')

figure
subplot(3, 2, 1)
plot(t, w_OLC(1, :), 'r')
hold on
plot(t, w_nonOLC(1, :), 'LineWidth', 3, Color=[0,0.4470,0.7410,0.5])
hold off
grid on
xlim([0, 50])
ylim([-0.05, 0.1])
ylabel('{\omega}_{x}')
legend('OLC', 'Non-OLC')
subplot(3, 2, 2)
plot(t, w_OLC(1, :), 'r')
hold on
plot(t, w_nonOLC(1, :), 'LineWidth', 3, Color=[0,0.4470,0.7410,0.5])
hold off
grid on
xlim([50, 100])
ylim([-0.005, 0.005])
subplot(3, 2, 3)
plot(t, w_OLC(2, :), 'r')
hold on
plot(t, w_nonOLC(2, :), 'LineWidth', 3, Color=[0,0.4470,0.7410,0.5])
hold off
grid on
xlim([0, 50])
ylim([-0.2, 0.1])
ylabel('{\omega}_{y}')
subplot(3, 2, 4)
plot(t, w_OLC(2, :), 'r')
hold on
plot(t, w_nonOLC(2, :), 'LineWidth', 3, Color=[0,0.4470,0.7410,0.5])
hold off
grid on
xlim([50, 100])
ylim([-0.0002, 0.0002])
subplot(3, 2, 5)
plot(t, w_OLC(3, :), 'r')
hold on
plot(t, w_nonOLC(3, :), 'LineWidth', 3, Color=[0,0.4470,0.7410,0.5])
hold off
grid on
xlim([0, 50])
ylim([-0.05, 0.2])
ylabel('{\omega}_{z}')
subplot(3, 2, 6)
plot(t, w_OLC(3, :), 'r')
hold on
plot(t, w_nonOLC(3, :), 'LineWidth', 3, Color=[0,0.4470,0.7410,0.5])
hold off
grid on
xlim([50, 100])
ylim([-0.00005, 0.00005])

figure
subplot(2, 2, 1)
plot(t, u_OLC(1, :))
hold on
plot(t, u_OLC(2, :))
plot(t, u_OLC(3, :))
hold off
grid on
xlim([0, 50])
ylim([-1, 1])
ylabel('OLC')
legend('u_1','u_2', 'u_3', 'Orientation', 'horizontal')
legend('boxoff')
subplot(2, 2, 2)
plot(t, u_OLC(1, :))
hold on
plot(t, u_OLC(2, :))
plot(t, u_OLC(3, :))
hold off
grid on
xlim([50, 100])
ylim([-0.2, 0.1])
subplot(2, 2, 3)
plot(t, u_nonOLC(1, :))
hold on
plot(t, u_nonOLC(2, :))
plot(t, u_nonOLC(3, :))
hold off
grid on
xlim([0, 50])
ylim([-1, 1])
ylabel('Non-OLC')
subplot(2, 2, 4)
plot(t, u_nonOLC(1, :))
hold on
plot(t, u_nonOLC(2, :))
plot(t, u_nonOLC(3, :))
hold off
grid on
xlim([50, 100])
ylim([-0.2, 0.1])

figure
subplot(3, 2, 1)
plot(t, phi_OLC, 'r')
hold on
plot(t, phi_nonOLC, 'LineWidth', 3, Color=[0,0.4470,0.7410,0.5])
hold off
grid on
xlim([0, 50])
ylim([-1, 0.5])
ylabel('Roll')
legend('OLC', 'Non-OLC')
subplot(3, 2, 2)
plot(t, phi_OLC, 'r')
hold on
plot(t, phi_nonOLC, 'LineWidth', 3, Color=[0,0.4470,0.7410,0.5])
hold off
grid on
xlim([50, 100])
ylim([-0.0002, 0.0002])
subplot(3, 2, 3)
plot(t, theta_OLC, 'r')
hold on
plot(t, theta_nonOLC, 'LineWidth', 3, Color=[0,0.4470,0.7410,0.5])
hold off
grid on
xlim([0, 50])
ylim([-0.5, 1])
ylabel('Pitch')
subplot(3, 2, 4)
plot(t, theta_OLC, 'r')
hold on
plot(t, theta_nonOLC, 'LineWidth', 3, Color=[0,0.4470,0.7410,0.5])
hold off
grid on
xlim([50, 100])
ylim([0, 0.015])
subplot(3, 2, 5)
plot(t, psi_OLC, 'r')
hold on
plot(t, psi_nonOLC, 'LineWidth', 3, Color=[0,0.4470,0.7410,0.5])
hold off
grid on
xlim([0, 50])
ylim([-0.4, 0.2])
ylabel('Yaw')
subplot(3, 2, 6)
plot(t, psi_OLC, 'r')
hold on
plot(t, psi_nonOLC, 'LineWidth', 3, Color=[0,0.4470,0.7410,0.5])
hold off
grid on
xlim([50, 100])
ylim([-0.01, 0.02])

figure
subplot(3, 2, 1)
plot(t, E(1, :), 'r')
grid on
xlim([0, 500])
ylim([1, 4])
ylabel('E_x')
subplot(3, 2, 2)
plot(t, E(1, :), 'r')
grid on
xlim([500, 2000])
ylim([0.94, 1])
subplot(3, 2, 3)
plot(t, E(2, :), 'r')
grid on
xlim([0, 500])
ylim([0.8, 1.4])
ylabel('E_y')
subplot(3, 2, 4)
plot(t, E(2, :), 'r')
grid on
xlim([500, 2000])
ylim([0.995, 1])
subplot(3, 2, 5)
plot(t, E(3, :), 'r')
grid on
xlim([0, 500])
ylim([1, 2])
ylabel('E_z')
subplot(3, 2, 6)
plot(t, E(3, :), 'r')
grid on
xlim([500, 2000])
ylim([0.9, 1.1])