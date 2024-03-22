clear

format shortE;

betaq = 0.001;
betaw = 0.001;
wpi = 0.0011;
w0 = [0 -wpi 0]' + betaw.*[-1+2*rand -1+2*rand -1+2*rand]';
ep0 = 0.66 + betaq * (-1+2*rand);
q0 = [0.34 -0.62 0.25]' + betaq.*[-1+2*rand -1+2*rand -1+2*rand]';
ILC0 = [w0; ep0; q0];
h = 0.01;
T = 800;
n = T/h+1;
theta = zeros(1, n);

k = 0: 50;

we_max = zeros(1, length(k));
alpha_max = zeros(1, length(k));

for i = k
    theta_d = theta;
    A = 0.5*(2*rand(3)-ones(3));
    dJk = tril(A, -1)+triu(A', 0);
    ILC_2;
    we_max(i+1) = max(wen);
    alpha_max(i+1) = max(alpha);
end
