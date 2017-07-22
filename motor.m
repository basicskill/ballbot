W = 0;

Ktg = 1;
Kem = 1;

R = 1;
J = 2;
B = 0.1;
L = 0.1;

dt = 0.01;

vreme = 0.0: dt: 20.0;
u1 = ones(size(vreme))*5;


U = 5;

s = tf('s');
t = sym('t');

Mt = t;

H = (Kem/R)*U - 1/s^2;

G = 1/(s*J+B);

GH = G*H;
TF = GH/(1+GH);

lsim(TF, u1, vreme);

%step = 2.5;
%U = zeros(1/dt);
%U = cat(1, U, step*ones(19/dt, 1));
