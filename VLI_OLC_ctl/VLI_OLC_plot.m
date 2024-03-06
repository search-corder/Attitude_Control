t = 0:0.01:1000;

we_VLI_OLC = reshape(we_VLI_OLC, 3, length(we_VLI_OLC));
T_VLI_OLC = reshape(T_VLI_OLC, 3, length(T_VLI_OLC));
P_VLI_OLC = reshape(P_VLI_OLC, 3, length(P_VLI_OLC));

we_OLC = reshape(we_OLC, 3, length(we_OLC));
T_OLC = reshape(T_OLC, 3, length(T_OLC));
P_OLC = reshape(P_OLC, 3, length(P_OLC));

we_NonOLC = reshape(we_NonOLC, 3, length(we_NonOLC));
T_NonOLC = reshape(T_NonOLC, 3, length(T_NonOLC));
P_NonOLC = reshape(P_NonOLC, 3, length(P_NonOLC));

euler_VLI_OLC = Euler_VLI_OLC';
euler_OLC = Euler_OLC';
euler_NonOLC = Euler_NonOLC';

d = reshape(d, 3, length(d));

E_VLI_OLC = P_VLI_OLC./P_NonOLC;
E_OLC = P_OLC./P_NonOLC;

figure
subplot(3, 2, 1)
plot(t1, we_VLI_OLC(1, :))
hold on
plot(t2, we_OLC(1, :))
plot(t3, we_NonOLC(1, :))
xlim([0, 100])
ylim([-0.05, 0.125])
ylabel('{\omega}_{e,x}')
legend('VLI-OLC', 'OLC', 'Non-OLC')
hold off
subplot(3, 2, 2)
plot(t1, we_VLI_OLC(1, :))
hold on
plot(t2, we_OLC(1, :))
plot(t3, we_NonOLC(1, :))
xlim([100, 200])
ylim([-0.005, 0.005])
hold off
subplot(3, 2, 3)
plot(t1, we_VLI_OLC(2, :))
hold on
plot(t2, we_OLC(2, :))
plot(t3, we_NonOLC(2, :))
xlim([0, 100])
ylim([-0.2, 0.1])
ylabel('{\omega}_{e,y}')
hold off
subplot(3, 2, 4)
plot(t1, we_VLI_OLC(2, :))
hold on
plot(t2, we_OLC(2, :))
plot(t3, we_NonOLC(2, :))
xlim([100, 200])
ylim([-0.005, 0.005])
hold off
subplot(3, 2, 5)
plot(t1, we_VLI_OLC(3, :))
hold on
plot(t2, we_OLC(3, :))
plot(t3, we_NonOLC(3, :))
xlim([0, 100])
ylim([-0.05, 0.15])
ylabel('{\omega}_{e,z}')
hold off
subplot(3, 2, 6)
plot(t1, we_VLI_OLC(3, :))
hold on
plot(t2, we_OLC(3, :))
plot(t3, we_NonOLC(3, :))
xlim([100, 200])
ylim([-0.005, 0.005])
hold off

figure
subplot(3, 2, 1)
plot(t1, euler_VLI_OLC(1, :))
hold on
plot(t2, euler_OLC(1, :))
plot(t3, euler_NonOLC(1, :))
xlim([0, 100])
ylim([-0.6, 0.3])
legend('VLI-OLC', 'OLC', 'Non-OLC')
ylabel('Roll')
hold off
subplot(3, 2, 2)
plot(t1, euler_VLI_OLC(1, :))
hold on
plot(t2, euler_OLC(1, :))
plot(t3, euler_NonOLC(1, :))
xlim([100, 200])
ylim([-0.02, 0.02])
hold off
subplot(3, 2, 3)
plot(t1, euler_VLI_OLC(2, :))
hold on
plot(t2, euler_OLC(2, :))
plot(t3, euler_NonOLC(2, :))
xlim([0, 100])
ylim([-0.4, 0.6])
ylabel('Pitch')
hold off
subplot(3, 2, 4)
plot(t1, euler_VLI_OLC(2, :))
hold on
plot(t2, euler_OLC(2, :))
plot(t3, euler_NonOLC(2, :))
xlim([100, 200])
ylim([-0.02, 0.02])
hold off
subplot(3, 2, 5)
plot(t1, euler_VLI_OLC(3, :))
hold on
plot(t2, euler_OLC(3, :))
plot(t3, euler_NonOLC(3, :))
xlim([0, 100])
ylim([-0.65, 0.25])
ylabel('Yaw')
hold off
subplot(3, 2, 6)
plot(t1, euler_VLI_OLC(3, :))
hold on
plot(t2, euler_OLC(3, :))
plot(t3, euler_NonOLC(3, :))
xlim([100, 200])
ylim([-0.02, 0.02])
hold off

figure
subplot(3, 2, 1)
plot(t1, T_VLI_OLC(1, :))
hold on
plot(t1, T_VLI_OLC(2, :))
plot(t1, T_VLI_OLC(3, :))
xlim([0, 100])
ylim([-1, 1])
ylabel('VLI-OLC')
legend('u_1', 'u_2', 'u_3')
hold off
subplot(3, 2, 2)
plot(t1, T_VLI_OLC(1, :))
hold on
plot(t1, T_VLI_OLC(2, :))
plot(t1, T_VLI_OLC(3, :))
xlim([100, 200])
ylim([-0.05, 0.05])
hold off
subplot(3, 2, 3)
plot(t2, T_OLC(1, :))
hold on
plot(t2, T_OLC(2, :))
plot(t2, T_OLC(3, :))
xlim([0, 100])
ylim([-1, 1])
ylabel('OLC')
hold off
subplot(3, 2, 4)
plot(t2, T_OLC(1, :))
hold on
plot(t2, T_OLC(2, :))
plot(t2, T_OLC(3, :))
xlim([100, 200])
ylim([-0.05, 0.05])
hold off
subplot(3, 2, 5)
plot(t3, T_NonOLC(1, :))
hold on
plot(t3, T_NonOLC(2, :))
plot(t3, T_NonOLC(3, :))
xlim([0, 100])
ylim([-1, 1])
ylabel('Non-OLC')
hold off
subplot(3, 2, 6)
plot(t3, T_NonOLC(1, :))
hold on
plot(t3, T_NonOLC(2, :))
plot(t3, T_NonOLC(3, :))
xlim([100, 200])
ylim([-0.05, 0.05])
hold off

figure
subplot(3, 1, 1)
plot(t1, delJ)
ylim([-2, 7])
xlim([0, 200])
legend('\DeltaJ_1', '\DeltaJ_2', '\DeltaJ_3')
ylabel('{\Delta}J')
subplot(3, 1, 2)
plot(t1, d)
ylim([-0.02, 0.02])
xlim([0, 200])
legend('d_1', 'd_2', 'd_3')
ylabel('d(t)')
subplot(3, 1, 3)
plot(t, k)
ylim([0, 1.2])
xlim([0, 200])
legend('k_{1,1}', 'k_{1,2}', 'k_{1,3}')
ylabel('VLI')

figure
subplot(3, 2, 1)
plot(t, E_VLI_OLC(1, :))
hold on
plot(t, E_OLC(1, :))
%ylim([0, 3])
xlim([0, 500])
legend('VLI-OLC', 'OLC')
ylabel('E_x')
hold off
subplot(3, 2, 2)
plot(t, E_VLI_OLC(1, :))
hold on
plot(t, E_OLC(1, :))
%ylim([0.9, 1])
xlim([500, 1000])
hold off
subplot(3, 2, 3)
plot(t, E_VLI_OLC(2, :))
hold on
plot(t, E_OLC(2, :))
%ylim([0, 3])
xlim([0, 500])
ylabel('E_y')
hold off
subplot(3, 2, 4)
plot(t, E_VLI_OLC(2, :))
hold on
plot(t, E_OLC(2, :))
%ylim([0.9, 0.96])
xlim([500, 1000])
hold off
subplot(3, 2, 5)
plot(t, E_VLI_OLC(3, :))
hold on
plot(t, E_OLC(3, :))
%ylim([0, 3])
xlim([0, 500])
ylabel('E_z')
hold off
subplot(3, 2, 6)
plot(t, E_VLI_OLC(3, :))
hold on
plot(t, E_OLC(3, :))
%ylim([0.8, 1.1])
xlim([500, 1000])
hold off