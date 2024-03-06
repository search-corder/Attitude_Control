clear

betaq = 0.001;
betaw = 0.001;
wpi = 0.0011;
w0 = [0 -wpi 0]' + betaw.*[-1+2*rand -1+2*rand -1+2*rand]';
ep0 = 0.66 + betaq * (-1+2*rand);
q0 = [0.34 -0.62 0.25]' + betaq.*[-1+2*rand -1+2*rand -1+2*rand]';
ILC0 = [w0; ep0; q0];
h = 0.01;
T = 1200;
n = T/h+1;
theta = zeros(1, n);

k = 200;

we_max = zeros(1, k);
alpha_max = zeros(1, k);

for i = 1: k
    theta_d = theta;
    ILC;
    we_max(i) = max(max(abs(we)));
    alpha_max(i) = max(abs(alpha));
end

plot(we_max)
plot(alpha_max)
