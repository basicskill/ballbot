W = 0;

Ktg = 1;
Kem = 1;

R = 1;
J = 2;
B = 0.1;
L = 0.1;

dt = 0.01;

vreme = 0.0: dt: 20.0; % vektor vremena
u1 = ones(size(vreme))*5; % vektor pobude

Ktg = 1;
A = 1;
U = 5;

s = tf('s');
%t = sym('t');


G = 1/(s*J+B); % transfer funkcija motora

TF =A * (G / (1 + Ktg * G)) % TF sa povratnom spregom (samo tahogenerator)

lsim(TF, u1, vreme);

